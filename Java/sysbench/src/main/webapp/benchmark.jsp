<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@page import="com.sysbench.connection.User" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Benchmarking...</title>
    <link rel="stylesheet" href="css/benchmark.css" />
  </head>
  <body>
    <div class="main">
      <div class="header_img"><img src="asserts/Sysbench.png" alt="" /></div>
      <div class="container">
        <div class="left">
            <div class="console">
                    <div id="title">Console Output</div>
                    <div class="texts">
                    
                    <%
                   
					User user = (User)session.getAttribute("user");
					String ip = user.getIp();
					int port = user.getPort();
					String userName = user.getUserName();
					String password = user.getPassword();
					int testType = Integer.parseInt(request.getParameter("test_type"));
					int threads = Integer.parseInt(request.getParameter("threads"));
					int time = Integer.parseInt(request.getParameter("time"));
					int events = Integer.parseInt(request.getParameter("events"));
					int tables = Integer.parseInt(request.getParameter("tables"));
					int records = Integer.parseInt(request.getParameter("records"));
					int interval = Integer.parseInt(request.getParameter("interval"));
					int steps = Integer.parseInt(request.getParameter("steps"));
					String range = request.getParameter("range");
					String dbps = request.getParameter("dbps");
					String loop = request.getParameter("loop");
					boolean dbexist = (boolean) session.getAttribute("dbexist");
					
					String option="oltp_read_only";
					if(testType == 2) {
						option="oltp_read_write";
					}
					else if (testType == 3) {
						option="oltp_write_only";
					}
					
					if (range==null) range="off";
					if (dbps==null) dbps="disable";
					
					String command;
					String output;
		
					
			if(loop==null) {
				
		        command = "/opt/sysbench/sysbench_param.sh --option=" + option
		                + " --threads=" + threads
		                + " --events=" + events
		                + " --time=" + time
		                + " --host=" + ip
		                + " --user=" + userName
		                + " --password=" + password
		                + " --port=" + port
		                + " --tables=" + tables
		                + " --table_size=" + records
		                + " --range_select=" + range
		                + " --db_ps_mode=" + dbps
		                + " --report_interval=" + interval;
		        
		        
		
		        
			
			}
				else {
					
					//bash /opt/sysbench/loop_sys_param.sh --option=oltp_write_only --threads=5 --events=0 --time=5 --host=127.0.0.1 --user=gokul --password=Password@123 --port=3306 --tables=10 --table_size=1000000 --range_select=off --db_ps_mode=disable --report_interval=1 --step=1
					   
					command = "/opt/sysbench/loop_sys_param.sh --option=" + option
				                + " --threads=" + threads
				                + " --events=" + events
				                + " --time=" + time
				                + " --host=" + ip
				                + " --user=" + userName
				                + " --password=" + password
				                + " --port=" + port
				                + " --tables=" + tables
				                + " --table_size=" + records
				                + " --range_select=" + range
				                + " --db_ps_mode=" + dbps
				                + " --report_interval=" + interval
				                + " --step=" + steps;
				                
				        
				        
				}
			
			
				
				ProcessBuilder processBuilder;
				if(dbexist!=true){
					out.println("Creating Database");
					System.err.println("---------- creating datab");
	                out.println("<br/>");
					processBuilder = new ProcessBuilder();
					//bash /opt/sysbench/sysbench_prepare_param.sh --option=oltp_read_only --threads=5 --host=127.0.0.1 --user=gokul --password=Password@123 --port=3306 --tables=10 --table_size=1000000
					String prepare_cmd = "";
					
					prepare_cmd = "/opt/sysbench/sysbench_prepare_param.sh --option=" + option
			                + " --threads=" + threads
			                + " --host=" + ip
			                + " --user=" + userName
			                + " --password=" + password
			                + " --port=" + port
			                + " --tables=" + tables
			                + " --table_size=" + records;
			                
			        
					processBuilder.command("bash", "-c", prepare_cmd);

			        try {
			            // Start the process
			            Process process = processBuilder.start();
		
			            // Read the output
			            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
			            String line;
			            while ((line = reader.readLine()) != null) {
			                System.out.println(line);
			                out.println(line);
			                out.println("<br/>");
			            }
		
			            // Wait for the process to complete and get the exit value
			            int exitCode = process.waitFor();
			            System.out.println("\nExited with code: " + exitCode);
			            out.println("\nExited with code: " + exitCode);
			            	            

		        } catch (IOException e) {
		            e.printStackTrace();
		        }
				
				}
				processBuilder = new ProcessBuilder();
		        // Split the command and its arguments
		        processBuilder.command("bash", "-c", command);
	
		        try {
		            // Start the process
		            Process process = processBuilder.start();
	
		            // Read the output
		            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
		            String line;
		            while ((line = reader.readLine()) != null) {
		                System.out.println(line);
		                out.println(line);
		                out.println("<br/>");
		            }
	
		            // Wait for the process to complete and get the exit value
		            int exitCode = process.waitFor();
		            System.out.println("\nExited with code: " + exitCode);
		            out.println("\nExited with code: " + exitCode);
		            	            

	        } catch (IOException e) {
	            e.printStackTrace();
	        }
				
				%>
                    
                    
                    
                    </div>
                
            </div>
        </div>
        <div class="right">
        	<h3>Test conducted <%= option %></h3>
            <div class="img">
            <%if (loop!=null) {
				processBuilder = new ProcessBuilder();
				
		        // Split the command and its arguments
		        processBuilder.command("bash", "-c", "/opt/sysbench/sys_analyse2_param.sh");
		        try {
		            // Start the process
		            Process process = processBuilder.start();
	
		            // Read the output
		            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
		            String line;
		            while ((line = reader.readLine()) != null) {
		                System.out.println(line);
		                out.println(line);
		                out.println("<br/>");
		            }
	
		            // Wait for the process to complete and get the exit value
		            int exitCode = process.waitFor();
		            System.out.println("\nExited with code: " + exitCode);
		            //out.println("\nExited with code: " + exitCode);
		            	            

	        } catch (IOException e) {
	            e.printStackTrace();
	        }
            
            %>
            	<img src="results.png">
            	<% } %>
            </div>
        </div>
      </div>
    </div>
  </body>
</html>
