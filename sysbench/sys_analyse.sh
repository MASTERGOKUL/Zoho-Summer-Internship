transactions=$(awk '/transaction/ {print $4}' monitor_log)

ecount=$(echo "$transactions" | awk -F'[()]' '{
    count += 1
    if ($2 > max) {
        max = $2
        exact_count = count
    }
    if (min==0 || min > $2) {
        min = $2
        min_thread = count
    }
}
END {
    print exact_count
}')

mthread=$(echo "$transactions" | awk -F'[()]' '{
    count += 1
    if ($2 > max) {
        max = $2
        exact_count = count
    }
    if (min==0 || min > $2) {
        min = $2
        min_thread = count
    }
}
END {
    print min_thread
}')

echo "$transactions" | awk -F'[()]' '{
    count += 1
    if ($2 > max) {
        max = $2
        exact_count = count
    }
    if (min==0 || min > $2) {
        min = $2
        min_thread = count
    }
}
END {
    print "Maximum Transactions Per Second:", max , "On Thread :", exact_count 
    print "Minimum Transactions Per Second:", min , "On Thread :", min_thread
}' 
min_latency=$(awk '/average latency/ {print $4}' monitor_log | awk -v ecount=$ecount'{print $ecount}')
echo $min_latency

echo "$transactions" | awk -F'[()]' '{
    count += 1
    if ($2 > max) {
        max = $2
        exact_count = count
    }
    if (min==0 || min > $2) {
        min = $2
    }
    print count, $2
}' | gnuplot -persist -e "set terminal jpeg;set title 'Transactions per Second'; set xlabel 'Count'; set ylabel 'Transactions'; plot '-' using 1:2 with linespoints title 'Transaction Value';" > demo.jpeg


eog demo.jpeg

