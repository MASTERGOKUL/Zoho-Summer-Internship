package com.sysbench.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import com.sysbench.connection.User;


public class Benchmark {
       
	public String exec_command(String command) {
//		ProcessBuilder processBuilder = new ProcessBuilder();
//		
//        // Split the command and its arguments
//        processBuilder.command("bash", "-c", command);
//
//        try {
//            // Start the process
//            Process process = processBuilder.start();
//
//            // Read the output
//            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
//            String line;
//            String output = "";
//            while ((line = reader.readLine()) != null) {
//            	output+=line+"\n";
//                System.out.println(line);
//            }
//
//            // Wait for the process to complete and get the exit value
//            int exitCode = process.waitFor();
//            System.out.println("\nExited with code: " + exitCode);
//            return output;
//            
//
//        } catch (IOException | InterruptedException e) {
//            e.printStackTrace();
//        }
        return null;

	}
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		/*
		 * HttpSession session = req.getSession(); User user =
		 * (User)session.getAttribute("user"); String ip = user.getIp(); int port =
		 * user.getPort(); String userName = user.getUserName(); String password =
		 * user.getPassword(); int testType =
		 * Integer.parseInt(req.getParameter("test_type")); int threads =
		 * Integer.parseInt(req.getParameter("threads")); int time =
		 * Integer.parseInt(req.getParameter("time")); int events =
		 * Integer.parseInt(req.getParameter("events")); int tables =
		 * Integer.parseInt(req.getParameter("tables")); int records =
		 * Integer.parseInt(req.getParameter("records")); int interval =
		 * Integer.parseInt(req.getParameter("interval")); int steps =
		 * Integer.parseInt(req.getParameter("steps")); String range =
		 * req.getParameter("range"); String dbps = req.getParameter("dbps"); String
		 * loop = req.getParameter("loop");
		 * 
		 * String option="oltp_read_only"; if(testType == 2) { option="oltp_read_write";
		 * } else if (testType == 3) { option="oltp_write_only"; }
		 * 
		 * if (range==null) range="off"; if (dbps==null) dbps="disable";
		 * 
		 * String command; String output;
		 * 
		 * if(loop==null) {
		 * 
		 * command = "/opt/sysbench/sysbench_param.sh --option=" + option +
		 * " --threads=" + threads + " --events=" + events + " --time=" + time +
		 * " --host=" + ip + " --user=" + userName + " --password=" + password +
		 * " --port=" + port + " --tables=" + tables + " --table_size=" + records +
		 * " --range_select=" + range + " --db_ps_mode=" + dbps + " --report_interval="
		 * + interval;
		 * 
		 * 
		 * 
		 * output = exec_command(command);
		 * 
		 * } else {
		 * 
		 * //bash /opt/sysbench/loop_sys_param.sh --option=oltp_write_only --threads=5
		 * --events=0 --time=5 --host=127.0.0.1 --user=gokul --password=Password@123
		 * --port=3306 --tables=10 --table_size=1000000 --range_select=off
		 * --db_ps_mode=disable --report_interval=1 --step=1
		 * 
		 * command = "/opt/sysbench/loop_sys_param.sh --option=" + option +
		 * " --threads=" + threads + " --events=" + events + " --time=" + time +
		 * " --host=" + ip + " --user=" + userName + " --password=" + password +
		 * " --port=" + port + " --tables=" + tables + " --table_size=" + records +
		 * " --range_select=" + range + " --db_ps_mode=" + dbps + " --report_interval="
		 * + interval + " --step=" + steps;
		 * 
		 * 
		 * 
		 * 
		 * output = exec_command(command); }
		 * 
		 * PrintWriter out = res.getWriter();
		 * 
		 * out.println(command); out.println(range); out.println(output);
		 */
		
	}

}
