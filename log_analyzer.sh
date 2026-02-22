#!/bin/bash

# q3_log_analyzer.sh
# This script analyzes a log file and displays statistics

echo "Enter log file name:"
read logfile

# Check if file exists
if [ ! -f "$logfile" ]; then
    echo "Log file does not exist."
    exit 1
fi

echo " LOG FILE ANALYSIS "

# Total lines
echo "Total Lines: $(wc -l < $logfile)"

# Count ERROR entries
echo "Total ERROR entries: $(grep -c "ERROR" $logfile)"

# Count WARNING entries
echo "Total WARNING entries: $(grep -c "WARNING" $logfile)"

# Count INFO entries
echo "Total INFO entries: $(grep -c "INFO" $logfile)"

# Display last 5 lines
echo "Last 5 lines of log:"
tail -5 $logfile

echo " ANALYSIS COMPLETE "