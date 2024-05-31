#------------------------------ Thred No -----------------------------------------

declare -a thread=($(awk '/Threads/ {print $3}' monitor_log))


# -------------------- Average CPU Utilization --------------------------------

declare -a cpu=($(awk '/Average CPU/ {print $4}' monitor_log))

cpu_graph=""

# Convert the array into x y pairs
for index in "${!cpu[@]}"; 
do
    x_value=${thread[$index]}
    y_value=${cpu[$index]}
    cpu_graph+="$x_value $y_value\n"
done
echo -e "$cpu_graph" | gnuplot -persist -e "
    set terminal jpeg;
    set title 'Average CPU Utilization';
    set xlabel 'Thread';
    set ylabel 'CPU Utilization';
    plot '-' using 1:2 with linespoints title 'CPU';
" > cpu.jpeg


#-------------------    Transactions per second  ----------------------------

declare -a transactions=($(awk '/transactions/ {print $4}' monitor_log |tr -d '()'))

# Initialize an empty string for the formatted data
transactions_graph=""

# Convert the array into x y pairs
for index in "${!transactions[@]}"; 
do
    x_value=${thread[$index]}
    y_value=${transactions[$index]}
    transactions_graph+="$x_value $y_value\n"
done

echo -e "$transactions_graph" | gnuplot -persist -e "
    set terminal jpeg;
    set title 'Transactions per Second';
    set xlabel 'Thread';
    set ylabel 'Transactions';
    plot '-' using 1:2 with linespoints title 'Transaction Value';
">transactions.jpeg


#----------------------    Min Latency --------------------------

declare -a min_latency=($(awk '/minimum latency/ {print $4}' monitor_log))


#-----------------------   Max Latency -----------------------------

declare -a max_latency=($(awk '/maximum latency/ {print $4}' monitor_log))

# Initialize an empty string for the formatted data
max_latency_graph=""

# Convert the array into x y pairs
for index in "${!max_latency[@]}"; 
do
    x_value=${thread[$index]}
    y_value=${max_latency[$index]}
    max_latency_graph+="$x_value $y_value\n"
done

echo -e "$max_latency_graph" | gnuplot -persist -e "
    set terminal jpeg;
    set title 'Maximum Latency';
    set xlabel 'Thread';
    set ylabel 'Maximum Latency (ms)';
    plot '-' using 1:2 with linespoints title 'Latency Value';
">max_latency.jpeg


#-----------------------  Avg Latency --------------------------------

declare -a avg_latency=($(awk '/average latency/ {print $4}' monitor_log))

avg_latency_graph=""

# Convert the array into x y pairs
for index in "${!avg_latency[@]}"; 
do
    x_value=${thread[$index]}
    y_value=${avg_latency[$index]}
    avg_latency_graph+="$x_value $y_value\n"
done

echo -e "$avg_latency_graph" | gnuplot -persist -e "
    set terminal jpeg;
    set title 'Average Latency';
    set xlabel 'Thread';
    set ylabel 'Average Latency (ms)';
    plot '-' using 1:2 with linespoints title 'Latency Value';
" > average_latency.jpeg



# ----------------------- Total Latency -------------------------------

declare -a total_latency=($(awk '/total latency/ {print $4}' monitor_log))

# ----------------------- Average IDLE -------------------------------

declare -a avg_io_wait=($(awk '/IO wait/ {print $4}' monitor_log))
avg_io_wait_graph=''


for index in "${!avg_io_wait[@]}"; 
do
    x_value=${thread[$index]}
    y_value=${avg_io_wait[$index]}
    avg_io_wait_graph+="$x_value $y_value\n"
done

echo -e "$avg_io_wait_graph" | gnuplot -persist -e "
    set terminal jpeg;
    set title 'Average IO wait';
    set xlabel 'Thread';
    set ylabel 'Average IO wait (% of cpu time)';
    plot '-' using 1:2 with linespoints title 'IO wait Value';
" > average_io_wait.jpeg

# ----------------------- Caluclations -----------------------------------
max_transaction_index=0
min_transaction_index=0
check_dropped=0 
drop_num=1
drop_index=0
for index in "${!transactions[@]}";
do

    # to find maximum transactions per second
    curr_trans=${transactions[$index]}
    max_trans=${transactions[$max_transaction_index]}
    
    if (( $(echo "$curr_trans > $max_trans" | bc -l) )); 
    then
        max_transaction_index=$index
    fi
    
    # to find minimum transactions per second
    if (($check_dropped == 1));
    then
    min_trans=${transactions[$min_transaction_index]}
     	if (( $(echo "$curr_trans < $min_trans" | bc -l) )); 
    	then
        	min_transaction_index=$index
    	fi
    fi
    
   
	
    # to find the drop point
    if (( index + 1 < ${#transactions[@]} )); 
    then 
    
        next_trans=${transactions[$index + 1]}
        
        curr_drop_num=$(echo "$curr_trans - $next_trans" | bc -l)
        if (( $(echo "$curr_drop_num > ($drop_num * 2)" | bc -l) )); 
        then
            check_dropped=1
            min_transaction_index=$index
            drop_num=$curr_drop_num
            drop_index=$index
        fi
    fi
done

# Highest Transaction
echo "$(tput setaf 2)******************* $(tput setaf 7) Highest Transaction Point $(tput setaf 2)******************$(tput setaf 7)"

echo "Number of Threads       : ${thread[$max_transaction_index]}"
echo "Average CPU Utilization : ${cpu[$max_transaction_index]}"
echo "Transaction Per Second  : ${transactions[$max_transaction_index]}"
echo "Average Latency         : ${avg_latency[$max_transaction_index]}"
echo "Minimum Latency         : ${min_latency[$max_transaction_index]}"
echo "Maximum Latency         : ${max_latency[$max_transaction_index]}"

# Highest Transaction
echo "$(tput setaf 3)******************* $(tput setaf 7) Largest Transactions Drop Point $(tput setaf 3)******************$(tput setaf 7)"

echo "Number of Threads       : ${thread[$drop_index]}"
echo "Drop Rate               : $drop_num"
echo "Average CPU Utilization : ${cpu[$drop_index]}"
echo "Transaction Per Second  : ${transactions[$drop_index]}"
echo "Average Latency         : ${avg_latency[$drop_index]}"
echo "Minimum Latency         : ${min_latency[$drop_index]}"
echo "Maximum Latency         : ${max_latency[$drop_index]}"

# Worst Transaction
echo "$(tput setaf 1)******************* $(tput setaf 7) Lowest Transaction Point $(tput setaf 1)******************$(tput setaf 7)"

echo "Number of Threads       : ${thread[$min_transaction_index]}"
echo "Average CPU Utilization : ${cpu[$min_transaction_index]}"
echo "Transaction Per Second  : ${transactions[$min_transaction_index]}"
echo "Average Latency         : ${avg_latency[$min_transaction_index]}"
echo "Minimum Latency         : ${min_latency[$min_transaction_index]}"
echo "Maximum Latency         : ${max_latency[$min_transaction_index]}"



#------------------------ Graph Showing ----------------------------------

#join horizontally
convert +append transactions.jpeg average_latency.jpeg horizontal1.jpeg

#join horizontally
convert +append cpu.jpeg average_io_wait.jpeg horizontal2.jpeg

#join vertically
convert -append horizontal1.jpeg horizontal2.jpeg result.jpeg

eog result.jpeg

