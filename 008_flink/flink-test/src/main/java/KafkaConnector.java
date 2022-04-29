import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.restartstrategy.RestartStrategies;
import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.runtime.state.filesystem.FsStateBackend;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer;

import java.time.Duration;
import java.util.Properties;

public class KafkaConnector {
    public static void main(String[] args) throws Exception {

        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "10.3.68.20:9092,10.3.68.21:9092,10.3.68.23:9092,10.3.68.26:9092,10.3.68.28:9092,10.3.68.32:9092,10.3.68.47:9092,10.3.68.48:9092,10.3.68.50:9092,10.3.68.52:9092");
        properties.setProperty("group.id", "test_thangdv");

        final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        final String checkpointDir = "file:///home/thangdv";
        env.setStateBackend(new FsStateBackend(checkpointDir));
        env.setRestartStrategy(RestartStrategies.fixedDelayRestart(2, 1000));
        env.enableCheckpointing(1000L);
        env.getConfig().disableGenericTypes();
        FlinkKafkaConsumer<String> consumer = new FlinkKafkaConsumer<>(
                "rt-retarget_banner",
                new SimpleStringSchema(),
                properties);
        consumer.assignTimestampsAndWatermarks(
                WatermarkStrategy.forBoundedOutOfOrderness(Duration.ofSeconds(15)));
        DataStream<String> stream = env.addSource(consumer);

        // Split up the lines in pairs (2-tuples) containing: (word,1)
        stream.map(new Tokenizer()).keyBy(0)
                .sum(1)
                .print();

        env.execute();
    }

    public static final class Tokenizer implements MapFunction<String, Tuple2<String, Integer>> {
        @Override
        public Tuple2<String, Integer> map(String value) throws Exception {
            if (value.contains("tiki.vn")) {
                return new Tuple2<>("tiki.vn", 1);
            }
            return new Tuple2<>("other", 1);
        }
    }
}
