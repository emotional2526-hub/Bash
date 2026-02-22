#!/bin/bash

# q5_user_report.sh
# This script generates a user account report with security checks

echo "= USER ACCOUNT REPORT ="

# Total users
echo "Total Users:"
cut -d: -f1 /etc/passwd | wc -l

# List users
echo "List of Users:"
cut -d: -f1 /etc/passwd

# Users with UID 0 (root privileges)
echo "Users with Root Privileges:"
awk -F: '($3 == 0) {print $1}' /etc/passwd

# Locked accounts
echo "Locked Accounts:"
sudo awk -F: '($2 ~ /^!/) {print $1}' /etc/shadow 2>/dev/null

# Password expiry info
echo "Password Expiry Information:"
chage -l $(whoami)

echo "= REPORT COMPLETE ="