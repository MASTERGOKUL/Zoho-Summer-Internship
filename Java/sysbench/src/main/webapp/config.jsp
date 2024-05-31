<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>Config</title>
    <link rel="stylesheet" href="css/config.css">
    </head>
    <body>
     <div class="main">
         <div class="left">
             <div class="header_img"><img src="asserts/Sysbench.png" alt=""></div>
             <form action="benchmark.jsp" method="post">
		          <select name="test_type" required>
		            <option value="null">-- Select a Test Option --</option>
		            <option value="1" selected>OLTP Read Only</option>
		            <option value="2">OLTP Read Write</option>
		            <option value="3">OLTP Write Only</option>
		          </select>
		          <input
		            type="number"
		            name="threads"
		            value="5"
		            placeholder="Enter No.of Threads"
		          />
		          <div class="inner_input">
		            <input type="number" name="time" value="5" placeholder="Exec Time (sec)" />
		            <input type="number" name="events" value="0" placeholder="No.of Events" />
		          </div>
		          <div class="inner_input">
		            <input type="number" name="tables" value="10" placeholder="No.of Tables" />
		            <input type="number" name="records" value="1000000" placeholder="No.of Records" />
		          </div>
		
		          <div class="inner_input">
		            <input
		              type="number"
		              name="interval"
		              value="1"
		              placeholder="Report Interval"
		            />
		            <input type="number" name="steps" value="1" placeholder="Loop Steps" />
		          </div>
		          <div class="all_checks">
		            <div class="check">
		              <input type="checkbox" name="range" id="range" />
		              <label for="range">Range Select</label>
		            </div>
		            <div class="check">
		              <input type="checkbox" name="dbps" id="dbps" />
		              <label for="dbps">DB-PS MOde</label>
		            </div>
		            <div class="check">
		                <input type="checkbox" name="loop" id="loop" checked/>
		                <label for="loop">Looped</label>
		              </div>
		          </div>
		          <input type="submit" />
        	</form>
                
                
                
            </div>
            <div class="confs">
                <div id="title">
                 Your MySQL configurations
                </div>
                <div class="contents">
                    <% 
                    HashMap<String,String> confs = (HashMap) request.getAttribute("confs");
                    for (String i : confs.keySet()) {
                         %>
                          <div class="row">
                          <div class="name"> <%= i %> </div> 
                          <div class="value"><%= ": " +confs.get(i) %></div> 
                      </div>
                     
                    <% }%>
              
                </div>
                
            </div>
        </div>
    </body>
    </html>