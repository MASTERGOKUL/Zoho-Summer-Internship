package com.sysbench.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Jdbc{
	public static Connection get_connection(User user) throws ClassNotFoundException{
	 String url = String.format("jdbc:mysql://%1$s:%2$d/",user.getIp(),user.getPort());
     String username = user.getUserName();
     String password = user.getPassword();

     // using try(){} -> try-with-resources to do auto close
     Class.forName("com.mysql.cj.jdbc.Driver");
     try {
    	 Connection connection = DriverManager.getConnection(url, username, password); 
        return connection;
     } 
     catch (SQLException e) {
         System.err.println("Failed to connect to the database.");
         e.printStackTrace();
     }
     
     return null;
     
     }
}
