package consumer;

import java.time.Duration;
import java.util.Arrays;
import java.util.Properties;

import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

public class SimpleConsumer {
	public static void main(String[] args) {
		Properties prop = new Properties();
		
		prop.put("bootstrap.servers", "localhost:9091");
		prop.setProperty("group.id", "test");
	    prop.setProperty("enable.auto.commit", "true");
	    prop.setProperty("auto.commit.interval.ms", "1000");
		prop.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		prop.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
		
		try (Consumer<String, String> consumer = new KafkaConsumer<String, String>(prop)) {
			consumer.subscribe(Arrays.asList("hello-kafka"));
			while(true) {
				ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100));
				for(ConsumerRecord<String, String> record: records) {
					System.out.println("offset = " + record.offset() + ", key = " + record.key() + ", "  + ", value = " + record.value());
				}
			}
		}
	}
}
