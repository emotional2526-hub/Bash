#!/bin/bash

# q1_system_info.sh
# This script displays important system information

echo " SYSTEM INFORMATION "

# Display hostname
echo "Hostname: $(hostname)"

# Display current user
echo "Logged in User: $(whoami)"

# Display current date and time
echo "Date & Time: $(date)"

# Display uptime
echo "System Uptime:"
uptime

# Display memory usage
echo "Memory Usage:"
free -h

# Display disk usage
echo "Disk Usage:"
df -h

echo " END OF REPORT "
