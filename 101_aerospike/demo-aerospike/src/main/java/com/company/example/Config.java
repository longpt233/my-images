package com.company.example;

import com.aerospike.client.Host;

public class Config {

    public static final Host[] HOSTS_NEW = new Host[] {
            new Host("172.18.5.10", 3000),
            new Host("172.18.5.11", 3000),
            new Host("172.18.5.12", 3000),
            new Host("172.18.5.13", 3000),
            new Host("172.18.5.14", 3000),
            new Host("172.18.5.15", 3000)
    };


    public static final String AEROSPIKE_NAMESPACE = "hdd_hadoop";
    public static final String AEROSPIKE_SET_1 = "app_uuid_mapper";
    public static final String AEROSPIKE_BIN_1 = "uuid";
    public static final String AEROSPIKE_BIN_2 = "";

}
