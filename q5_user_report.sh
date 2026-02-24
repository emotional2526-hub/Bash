#!/bin/bash

echo "========== USER STATISTICS =========="

TOTAL_USERS=$(wc -l < /etc/passwd)
SYSTEM_USERS=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)
REGULAR_USERS=$(awk -F: '$3 >= 1000 {count++} END {print count}' /etc/passwd)
LOGGED_IN=$(who | awk '{print $1}' | sort -u | wc -l)

echo "Total Users: $TOTAL_USERS"
echo "System Users (UID < 1000): $SYSTEM_USERS"
echo "Regular Users (UID >= 1000): $REGULAR_USERS"
echo "Currently Logged In: $LOGGED_IN"

echo ""
echo "========== REGULAR USER DETAILS =========="

printf "%-15s %-8s %-25s %-15s\n" "Username" "UID" "Home Directory" "Shell"
printf "%-15s %-8s %-25s %-15s\n" "--------" "---" "--------------" "-----"

awk -F: '$3 >= 1000 {printf "%-15s %-8s %-25s %-15s\n", $1, $3, $6, $7}' /etc/passwd

echo ""
echo "========== GROUP INFORMATION =========="

echo "Total Groups: $(wc -l < /etc/group)"
echo ""

awk -F: '{
    split($4, members, ",");
    count = (length($4) == 0 ? 0 : length(members));
    printf "%-20s Members: %d\n", $1, count
}' /etc/group

echo ""
echo "========== SECURITY ALERTS =========="

# Users with UID 0
echo "Users with root privileges (UID 0):"
awk -F: '$3 == 0 {print "- " $1}' /etc/passwd

# Users without passwords
echo ""

awk -F: '($2 == "" || $2 == "!" || $2 == "*") {print "- " $1}' /etc/shadow 2>/dev/null

# Inactive users (Never logged in)
echo ""


for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)
do
    LAST_LOGIN=$(last -n 1 $user | head -1)
    
    if [[ "$LAST_LOGIN" == *"wtmp begins"* ]]; then
        echo "- $user"
    fi
done