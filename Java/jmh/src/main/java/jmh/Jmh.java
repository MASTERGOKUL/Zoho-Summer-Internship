package jmh;

import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

import com.MyBenchmark;

import org.openjdk.jmh.runner.Runner;

public class Jmh {
    public static void main(String[] args) throws RunnerException {
        Options opt = new OptionsBuilder()
                .include(MyBenchmark.class.getSimpleName())
                .forks(1)
                .threads(5)
                .build();
//        System.out.println(MyBenchmark.class.getSimpleName());

        new Runner(opt).run();
    }
}
