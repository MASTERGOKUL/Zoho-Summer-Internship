# Initialize variables
option="oltp_read_only"
threads=8
events=0
time=5
host="127.0.0.1"
user="gokul"
password="Password@123"
port=3306
tables=10
table_size=1000000
range_select="off"
db_ps_mode="disable"
report_interval=1
step=1

# Parse command line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --option=*) option="${1#*=}";;
        --threads=*) threads="${1#*=}";;
        --events=*) events="${1#*=}";;
        --time=*) time="${1#*=}";;
        --host=*) host="${1#*=}";;
        --user=*) user="${1#*=}";;
        --password=*) password="${1#*=}";;
        --port=*) port="${1#*=}";;
        --tables=*) tables="${1#*=}";;
        --table_size=*) table_size="${1#*=}";;
        --range_select=*) range_select="${1#*=}";;
        --db_ps_mode=*) db_ps_mode="${1#*=}";;
        --report_interval=*) report_interval="${1#*=}";;
        --step=*) step="${1#*=}";;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

date>>/opt/sysbench/overall_monitor_loop_log_param

rm -f /opt/sysbench/monitor_loop_log_param

date>>/opt/sysbench/monitor_loop_log_param

option="/usr/share/sysbench/${option}.lua"

for (( i=1 ; i<=$threads ; i+=$step )); 
do 
	echo "$(tput setaf 1)************************ $(tput setaf 7) $((i)) Threads $(tput setaf 1) ************************$(tput setaf 7)" | tee -a /opt/sysbench/monitor_loop_log_param

	sar -u 1 $time > /opt/sysbench/cpu_utilization_loop_param.log &
	#sar -r 1 10 > memory_utilization.log &

	sysbench $option  --threads=$i --events=$events --time=$time --mysql-host=$host --mysql-user=$user --mysql-password=$password --mysql-port=$port --tables=$tables --table-size=$table_size --range_selects=$range_select --db-ps-mode=$db_ps_mode --report-interval=$report_interval run | tee /opt/sysbench/current_loop_log_param

	#sleep $time

	#CPU
	grep "Average" /opt/sysbench/cpu_utilization_loop_param.log | awk '{print "Average CPU Utilization: " $3+$5 " %"}' | tee -a /opt/sysbench/monitor_loop_log_param

	#IO wait
	awk '/Average/{print "Average IO wait: " $6 " %"}' /opt/sysbench/cpu_utilization_loop_param.log | tee -a /opt/sysbench/monitor_loop_log_param

	#RAM

	#awk '/Average/{print "Average Memory Utilization: " $4 "%"}' memory_utilization.log

	#THROUGHPUT
	awk '/transactions:/{print "transactions per sec " $3")"}' /opt/sysbench/current_loop_log_param | tee -a /opt/sysbench/monitor_loop_log_param


	#MIN LATENCY
	awk '/min:/{print "minimum latency (ms): " $2$3}' /opt/sysbench/current_loop_log_param | tee -a /opt/sysbench/monitor_loop_log_param

	#MAX LATENCY
	awk '/max:/{print "maximum latency (ms): " $2$3}' /opt/sysbench/current_loop_log_param | tee -a /opt/sysbench/monitor_loop_log_param


	#AVG LATENCY
	awk '/avg:/{print "average latency (ms): " $2$3}' /opt/sysbench/current_loop_log_param | tee -a /opt/sysbench/monitor_loop_log_param


	#TOTAL LATENCY
	awk '/sum:/{print "total latency (ms): " $2$3}' /opt/sysbench/current_loop_log_param | tee -a /opt/sysbench/monitor_loop_log_param


done

cat /opt/sysbench/monitor_loop_log_param >> /opt/sysbench/overall_monitor_loop_log_param


