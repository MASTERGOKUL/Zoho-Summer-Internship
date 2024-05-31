sar -u 1 5 > cpu_utilization.log &
#sar -r 1 10 > memory_utilization.log &

sysbench /usr/share/sysbench/oltp_write_only.lua  --threads=5 --events=0 --time=5 --mysql-host=127.0.0.1 --mysql-user=gokul --mysql-password=Password@123 --mysql-port=3306 --tables=10 --table-size=1000000 --range_selects=off --db-ps-mode=disable --report-interval=1 run | tee current_log

pkill sar

#CPU
grep "Average" cpu_utilization.log | awk '{print "Average CPU Utilization: " $3+$5 " %"}'

#IO wait
awk '/Average/{print "Average IO wait :" $6 " %"}' cpu_utilization.log

#IDLE
awk '/Average/{print "Average Idle :" $7 " %"}' cpu_utilization.log


#RAM

#awk '/Average/{print "Average Memory Utilization: " $4 "%"}' memory_utilization.log

#THROUGHPUT
awk '/transactions:/{print "transactions per sec " $3")"}' current_log


#MIN LATENCY
awk '/min:/{print "minimum latency (ms): " $2$3}' current_log

#MAX LATENCY
awk '/max:/{print "maximum latency (ms): " $2$3}' current_log


#AVG LATENCY
awk '/avg:/{print "average latency (ms): " $2$3}' current_log

#TOTAL LATENCY
awk '/sum:/{print "total latency (ms): " $2$3}' current_log

