logFile="memory_logFile.tsv"

# Email recipient
recipient="rnagatarun@gmail.com"

if [ ! -f "$logFile" ]; then
    # If the file doesn't exist, add a header
    echo "Date and Time                | Memory Usage (%)" > "$logFile"
    echo "---------------------------- | ----------------" >> "$logFile"
fi

while true; do
    memoryUsed=$(free -m | head -2 | tail -1 | awk '{print $3}')
    totalMemory=$(free -m | head -2 | tail -1 | awk '{print $2}')
    
    memoryPercentageUsed=$((memoryUsed * 100 / totalMemory))

    dateTime=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$dateTime | $memoryPercentageUsed%" >> "$logFile"

    # Check if memory usage is greater than or equal to 80% for sending email
    if [[ $memoryPercentageUsed -ge 80 ]]; then
        # Email notification
        echo -e "Subject: Memory Usage Alert\n\nMemory usage has reached $memoryPercentageUsed% as of $dateTime." | mail -s "Memory Alert" "$recipient"
        exit
    fi

    # Sleep for 5 seconds
    sleep 5
done
