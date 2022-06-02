package com.company.team.main;

import org.apache.flink.api.common.functions.AggregateFunction;
import org.apache.flink.api.java.functions.KeySelector;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.assigners.TumblingProcessingTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.connectors.wikiedits.WikipediaEditEvent;
import org.apache.flink.streaming.connectors.wikiedits.WikipediaEditsSource;
import scala.Tuple2;

public class WikipediaAnalysis {

    public static void main(String[] args) throws Exception {

        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStream<WikipediaEditEvent> edits = env.addSource(new WikipediaEditsSource());
        /*
        1. timestamp
        2. channel
        3. title
        4. diffUrl
        5. user
        6. byteDiff
        7. summary
        8. flags
         */

        KeyedStream<WikipediaEditEvent, String> keyedEdits = edits
                .keyBy((KeySelector<WikipediaEditEvent, String>) WikipediaEditEvent::getUser);

        DataStream<Tuple2<String, Long>> result = keyedEdits
                .window(TumblingProcessingTimeWindows.of(Time.seconds(20)))
                .aggregate(new AggregateFunction<WikipediaEditEvent, Tuple2<String, Long> , Tuple2<String, Long>>() {
                    @Override
                    public Tuple2<String, Long> createAccumulator() {
                        return new Tuple2<>("", 0L);
                    }

                    @Override
                    public Tuple2<String, Long> add(WikipediaEditEvent value, Tuple2<String, Long> accumulator) {
                        String log = String.format("%s\t%40s\t%8d\t%s",value.getTimestamp(),value.getUser(),value.getByteDiff(),accumulator);
                        System.out.println(log);

//                        if(accumulator._1.equals(value.getUser())) {
//                            Long totalDiff = value.getByteDiff() + accumulator._2;
//                            return new Tuple2<>(value.getUser(), totalDiff);
//                        }else {
//                            return new Tuple2<>(value.getUser(), (long)value.getByteDiff());
//                        }

                        Long totalDiff = value.getByteDiff() + accumulator._2;
                        return new Tuple2<>(value.getUser(), totalDiff);

                    }

                    @Override
                    public Tuple2<String, Long> getResult(Tuple2<String, Long> accumulator) {  // print cho 1 cai window
                        System.out.println(accumulator);
                        return accumulator;
                    }

                    @Override
                    public Tuple2<String, Long> merge(Tuple2<String, Long> stringLongTuple2, Tuple2<String, Long> acc1) {
                        return null;
                    }


                });

        env.execute();
    }
}