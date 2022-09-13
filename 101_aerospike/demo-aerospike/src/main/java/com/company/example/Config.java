package com.company.example;

import com.aerospike.client.Host;

public class Config {

    public static final Host[] HOSTS_NEW = new Host[] {
            new Host("172.26..", 10000),
            new Host("172.26..", 10000),
            new Host("172.26..", 10000),
            new Host("172.26..", 10000)
    };


    public static final String AEROSPIKE_NAMESPACE = "";
    public static final String AEROSPIKE_SET_1 = "";
    public static final String AEROSPIKE_BIN_1 = "";
    public static final String AEROSPIKE_BIN_2 = "";

}
