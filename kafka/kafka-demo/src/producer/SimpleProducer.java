package producer;

import java.util.Properties;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;

public class SimpleProducer {
	public static void main(String[] args) {
		Properties prop = new Properties();
		
		prop.put("bootstrap.servers", "localhost:9091");
		prop.put("retries", 0);
		prop.put("key.serializer", StringSerializer.class);
		prop.put("value.serializer", StringSerializer.class);
		
		Producer<String, String> producer = new KafkaProducer<String, String>(prop);
		
		for(int i=0; i<4; i++) {
			producer.send(new ProducerRecord<String, String>("hello-kafka", Integer.toString(i), "value "+Integer.toString(i)));
		}
		
		System.out.println("successfully!");
		producer.close();
	}
}
