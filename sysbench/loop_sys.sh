n=1024
date>>sysbench_logs

for (( i=2 ; i<=$n ; i=$i*2 )); 
do 
echo "$(tput setaf 1)************************ $(tput setaf 7) $((i))Threads $(tput setaf 1) ************************$(tput setaf 7)"
	sysbench /usr/share/sysbench/oltp_read_only.lua --threads=$((i)) --events=0 --time=5 --mysql-host=127.0.0.1 --mysql-user=gokul --mysql-password=Password@123 --mysql-port=3306 --tables=10 --table-size=1000000 --range_selects=off --db-ps-mode=disable --report-interval=1 run | tee -a sysbench_logs

done
