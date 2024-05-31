# Zoho-Summer-Internship

Zoho Summer Internship Start Date - 21 May 2024

📌 Task : To analyse and make a performance testing/ benchmarking tool for mysql

📌 Analysed some of the tools for benchmarking, choosed sysbench due to it gives some more parameters

📌 Created a simple web application that can run some load test using sysbench to make benchmarking easier...

---

1. The main code of sysbench is inside "Sysbench directory", it got lot of versions, 
  The code that is actually running inside the website are inside
* sysbench -> sysbench_prepare_param.sh (to prepare database for the test)
* sysbench -> loop_sys_param.sh (to run the test)
* sysbench -> sys_analyse2_param.sh (to get overall the analysis of the test)

 ---
2. You can able to see the website code , it is inside Java -> Sysbench
  * The main folders are
  * Java/sysbench/src/main/java/com/sysbench/connection/  -> java files related to db connection
  * Java/sysbench/src/main/java/com/sysbench/servlet -> java files related to servlet
  * Java/sysbench/src/main/webapp -> java files related to jsp
  * some of the jsp and the html likely same , first created the html to made the design and made the jsp to add the java code 
