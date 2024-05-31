n=152

date>>overall_monitor_log

rm -f monitor_log

date>>monitor_log


for (( i=1 ; i<=$n ; i+=5 )); 
do 
	echo "$(tput setaf 1)************************ $(tput setaf 7) $((i)) Threads $(tput setaf 1) ************************$(tput setaf 7)" | tee -a monitor_log

	sar -u 1 5 > cpu_utilization.log &
	#sar -r 1 10 > memory_utilization.log &

	sysbench /usr/share/sysbench/oltp_write_only.lua --threads=$((i)) --events=0 --time=5 --mysql-host=127.0.0.1 --mysql-user=gokul --mysql-password=Password@123 --mysql-port=3306 --tables=10 --table-size=1000000 --range_selects=off --db-ps-mode=disable --report-interval=1 run | tee current_log

	sleep 5

	#CPU
	grep "Average" cpu_utilization.log | awk '{print "Average CPU Utilization: " $3+$5 " %"}' | tee -a monitor_log

#IO wait
awk '/Average/{print "Average IO wait: " $6 " %"}' cpu_utilization.log | tee -a monitor_log

	#RAM

	#awk '/Average/{print "Average Memory Utilization: " $4 "%"}' memory_utilization.log

	#THROUGHPUT
	awk '/transactions:/{print "transactions per sec " $3")"}' current_log | tee -a monitor_log


	#MIN LATENCY
	awk '/min:/{print "minimum latency (ms): " $2$3}' current_log | tee -a monitor_log

	#MAX LATENCY
	awk '/max:/{print "maximum latency (ms): " $2$3}' current_log | tee -a monitor_log


	#AVG LATENCY
	awk '/avg:/{print "average latency (ms): " $2$3}' current_log | tee -a monitor_log


	#TOTAL LATENCY
	awk '/sum:/{print "total latency (ms): " $2$3}' current_log | tee -a monitor_log


done

cat monitor_log >> overall_monitor_log


