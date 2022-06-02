package com.company.team.main;

import com.company.team.utils.DataGenerator;
import com.company.team.utils.Word;
import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.common.functions.ReduceFunction;
import org.apache.flink.api.java.DataSet;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.utils.ParameterTool;
import org.apache.flink.util.Collector;

public class BatchJob {

    public void run() throws Exception {

        // set up the execution environment
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();

        // make parameters available in the web interface
        env.setParallelism(1);

        // get input data
        DataSet<String> text = DataGenerator.getDefaultTextLineDataSet(env);

        DataSet<Word> counts =
                // split up the lines into Word objects (with frequency = 1)
                text.flatMap(new Tokenizer())
                        // group by the field word and sum up the frequency
                        .groupBy("word")
                        .reduce((ReduceFunction<Word>) (value1, value2) -> new Word(value1.getWord(), value1.getFrequency() + value2.getFrequency()));

        System.out.println("Printing result to stdout");
        counts.print();

    }

    public static void main(String[] args) throws Exception {
        BatchJob task = new BatchJob();
        task.run();

    }



    public static final class Tokenizer implements FlatMapFunction<String, Word> {

        @Override
        public void flatMap(String value, Collector<Word> out) {
            // normalize and split the line
            String[] tokens = value.toLowerCase().split("\\W+");

            // emit the pairs
            for (String token : tokens) {
                if (token.length() > 0) {
                    out.collect(new Word(token, 1));
                }
            }
        }
    }
}
