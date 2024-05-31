package com.sysbench.servlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import com.sysbench.connection.Jdbc;
import com.sysbench.connection.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user_details")
public class UserForm extends HttpServlet {
	// created to avoid serialize warning
	private static final long serialVersionUID = 2599245037305308154L;
	
	// to get configuration of the user
	public HashMap<String, String> get_configurations(Connection conn,PrintWriter out,HttpSession session) throws SQLException {
		String conf_queries_variables[] = {
				"key_buffer_size",
				"max_allowed_packet",
				"thread_stack",
				"thread_cache_size",
				"innodb_buffer_pool_size",
				"innodb_io_capacity",
				"innodb_log_file_size",
				"innodb_flush_log_at_trx_commit",
				"max_connections",
				"table_open_cache",
				"general_log_file",
				"general_log",
				"log_error",
				"slow_query_log",
				"slow_query_log_file",
				"long_query_time",
				"log_bin",
				"binlog_expire_logs_seconds",
				"max_binlog_size",
				
		};
		
		
		HashMap<String, String> confs = new HashMap<String, String>();
		
		try(Statement st = conn.createStatement();) {	

			for(String q_variable : conf_queries_variables) {
			ResultSet resultSet = st.executeQuery("SHOW VARIABLES LIKE '"+q_variable+"';");
			
			while (resultSet.next()) {
			    String var_name = resultSet.getString("Variable_name");
			    String value = resultSet.getString("Value");
			    confs.put(var_name, value);
			}
			}
			String query = "SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = '" + "sbtest" + "'";
            ResultSet resultSet = st.executeQuery(query);
            if(resultSet.next()) {
            session.setAttribute("dbexist", true);
            }
            else {
            	st.executeUpdate("CREATE DATABASE sbtest;");
            	 session.setAttribute("dbexist", false);
            }

		} catch(Exception e) {
			System.out.println(e);
		}
		return confs;
		
		
	}

	
	// to execute post method requests
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		String ip = req.getParameter("ip");
		int port = Integer.parseInt(req.getParameter("port"));
		String username = req.getParameter("user_name");	
		String password = req.getParameter("password");
		
		
		HttpSession session = req.getSession();
		
		User user = new User(ip,port,username,password);
		Connection conn = null;
		try {
			conn = Jdbc.get_connection(user);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		
		HashMap<String, String> confs = null ;
		PrintWriter out = res.getWriter();
		
		try {
			confs = get_configurations(conn,out,session);
			conn.close();
		} catch (SQLException e) {
			out.println("error");
			e.printStackTrace();
		}
		
		
		
		session.setAttribute("user", user);
		req.setAttribute("confs", confs);
		
		// redirecting to jsp page with values
		RequestDispatcher rq = req.getRequestDispatcher("/config.jsp");
		rq.forward(req, res);
		
}
}
