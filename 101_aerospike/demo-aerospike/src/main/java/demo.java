import com.aerospike.client.*;
import com.aerospike.client.policy.ClientPolicy;
import com.aerospike.client.policy.Policy;
import com.aerospike.client.policy.TlsPolicy;
import com.aerospike.client.policy.WritePolicy;

public class demo {

    public static void main(String[] args) {

        Host aerospikeHost = new Host("localhost",3000);

        // tạo Policy cho aero client connect
        ClientPolicy clientPolicy = new ClientPolicy();

        // tạo connection
        AerospikeClient client = new AerospikeClient(clientPolicy,aerospikeHost);    // có thể truyền vào là 1 mảng host


        // tạo policy cho write
        WritePolicy writePolicy = new WritePolicy();
        writePolicy.setTimeouts(5000, 5000);    // socket timeout - total timeout
        writePolicy.maxRetries = 20;
        writePolicy.sendKey =true  ;


        // write
        Key key = new Key("test", "myset", "mykey-1");  // Namespace test, set myset, key mykey
        Bin bin = new Bin("mybin", "myvalue-1");            // colname mybin , value myvalue
//        client.put(writePolicy, key, bin);


        // read

        Policy policy = new Policy();
        Key find = new Key("test","myset","mykey-1");
        Record record = client.get(policy, find);

        System.out.println(record.bins);

    }

}
