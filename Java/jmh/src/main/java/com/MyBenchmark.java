//package com;
//
//import org.openjdk.jmh.annotations.Benchmark;
//
//public class MyBenchmark {
//    @Benchmark
//    public void testMethod() {
//        // Benchmark code here
//    }
//}
package com;

import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.TearDown;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.TimeUnit;


@State(Scope.Thread)
public class MyBenchmark {

    private Connection connection;
    private PreparedStatement preparedStatement;

    @Setup
    public void setup() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/tpcc2";
        String user = "gokul";
        String password = "Password@123";
        
        connection = DriverManager.getConnection(url, user, password);
        preparedStatement = connection.prepareStatement("SELECT * FROM customer");
    }

    @Benchmark
    @BenchmarkMode(Mode.AverageTime)
    public void testMethod1() throws SQLException {
    	setup();
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            // Process the result if needed
//            int id = resultSet.getInt("eid");
//            String name = resultSet.getString("ename");
//            String office = resultSet.getString("eoffice");
        }
        resultSet.close();
        tearDown();
    }
    @Benchmark
    public void testMethod2() throws SQLException {
    	setup();
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            // Process the result if needed
//            int id = resultSet.getInt("eid");
//            String name = resultSet.getString("ename");
//            String office = resultSet.getString("eoffice");
        }
        resultSet.close();
        tearDown();
    }

    @TearDown
    public void tearDown() throws SQLException {
        preparedStatement.close();
        connection.close();
    }
}
