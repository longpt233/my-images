package com.company.example;

import com.aerospike.client.*;
import com.aerospike.client.policy.ClientPolicy;
import com.aerospike.client.policy.ScanPolicy;
import com.aerospike.client.policy.WritePolicy;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

public class AeUtil {

    AerospikeClient aeClient;

    public AeUtil(){
        ClientPolicy clientPolicy = new ClientPolicy();
        clientPolicy.timeout = 600000;
        aeClient = new AerospikeClient(clientPolicy, Config.HOSTS_NEW);
    }

    public void writeToBin1Set1(String keyString, String value){
        Key key = new Key(Config.AEROSPIKE_NAMESPACE, Config.AEROSPIKE_SET_1, keyString);
        WritePolicy writePolicy = new WritePolicy();
        writePolicy.sendKey = true;
        Bin bin = new Bin(Config.AEROSPIKE_BIN_1, value);
        aeClient.put(writePolicy, key, bin);
    }

    public void writeToBinsSet1(String keyString, String value1, String value2){
        Key key = new Key(Config.AEROSPIKE_NAMESPACE, Config.AEROSPIKE_SET_1, keyString);
        WritePolicy writePolicy = new WritePolicy();
        writePolicy.setTimeouts(1000, 1000);
        writePolicy.expiration = 100000;
        writePolicy.sendKey = true;
        Bin[] bins = new Bin[]{
                new Bin(Config.AEROSPIKE_BIN_1, value1),
                new Bin(Config.AEROSPIKE_BIN_2, value2)
        };
        aeClient.put(writePolicy, key, bins);
    }

    public void truncateSet(long timeStart){
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(timeStart);
        aeClient.truncate(null, Config.AEROSPIKE_NAMESPACE, Config.AEROSPIKE_SET_1, calendar);
    }

    public void readSet(){
        ScanPolicy scanPolicy = new ScanPolicy();
//        scanPolicy.= 1000;
//        List<Record> scanRecord= new ArrayList<>();
        List<Record> scanRecord = Collections.synchronizedList(new ArrayList<>());  // must sync
        aeClient.scanAll(scanPolicy, Config.AEROSPIKE_NAMESPACE, Config.AEROSPIKE_SET_1, (key, record) -> {
//            System.out.println(record);
            scanRecord.add(record);
        });

        System.out.println(scanRecord.size());

    }

}
