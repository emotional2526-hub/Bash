#!/bin/bash

# q3_log_analyzer.sh
# This script analyzes a log file and displays statistics


# Check if filename is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

LOGFILE=$1

# Check if file exists
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File does not exist!"
    exit 1
fi

# Check if file is empty
if [ ! -s "$LOGFILE" ]; then
    echo "Log file is empty!"
    exit 1
fi

echo "================================="
echo "       LOG FILE ANALYSIS"
echo "================================="
echo "Log File: $LOGFILE"

# Total number of entries
TOTAL=$(wc -l < "$LOGFILE")
echo "Total Entries: $TOTAL"

echo ""

# Unique IP addresses
echo "Unique IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq
UNIQUE_COUNT=$(awk '{print $1}' "$LOGFILE" | sort | uniq | wc -l)
echo "Total Unique IPs: $UNIQUE_COUNT"

echo ""

# Status Code Summary
echo "Status Code Summary:"
awk '{print $NF}' "$LOGFILE" | sort | uniq -c | while read count code
do
    echo "$code : $count requests"
done

echo ""

# Most frequently accessed page
echo "Most Frequently Accessed Page:"
awk -F\" '{print $2}' "$LOGFILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -1 | while read count page
do
    echo "$page - $count requests"
done

echo ""

# Top 3 IP addresses
echo "Top 3 IP Addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -3 | nl

echo "================================="