#!/bin/bash

# Log file variable
logFile="memory_logFile.tsv"

# Check if the log file exists
if [ ! -f "$logFile" ]; then
    # If the file doesn't exist, add a header
    echo "Date and Time                | Memory Usage (%)" > "$logFile"
    echo "---------------------------- | ----------------" >> "$logFile"
fi

while true; do
    # Get current memory usage
    memoryUsed=$(free -m | head -2 | tail -1 | awk '{print $3}')
    totalMemory=$(free -m | head -2 | tail -1 | awk '{print $2}')
    
    # Calculate memory usage percentage
    memoryPercentageUsed=$((memoryUsed * 100 / totalMemory))

    # Get current date and time
    dateTime=$(date '+%Y-%m-%d %H:%M:%S')

    # Append the result to the log file
    echo "$dateTime | $memoryPercentageUsed%" >> "$logFile"

    # Check if memory usage is greater than or equal to 80%
    if [[ $memoryPercentageUsed -ge 80 ]]; then
        echo "Memory limit reached 80%" | espeak-ng
        exit
    fi

    # Sleep for 5 seconds
    sleep 5
done

