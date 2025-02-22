#!/bin/bash

echo "Running macOS version..."

# CPU Usage
echo "CPU Usage:"
top -l 1 -s 0 | awk '/CPU usage/ {print "User:", $3, "System:", $5, "Idle:", $7}'

# Memory Usage
echo "Memory Usage:"
top -l 1 -s 0 | awk '/PhysMem/ {print "Used:", $2, "Free:", $4, "Wired:", $6, "Inactive:", $8}'
echo "$memory_usage"

# Disk Usage
echo -e "\nDisk Usage:"
df -H | awk 'NR==1 || /\/dev\// {print "Filesystem:", $1, "Total:", $2, "Used:", $3, "(", $5, ")"}'

# Top 5 CPU-consuming processes
echo -e "\nTop 5 Processes by CPU Usage:"
ps -A -o pid,command,%cpu | sort -k3 -r | head -n 5

# Top 5 Memory-consuming processes
echo -e "\nTop 5 Processes by Memory Usage:"
ps -axo pid,comm,%mem | sort -k3 -r | head -n 6


# OS Version
echo -e "\nOS Version:"
sw_vers -productVersion

# Uptime
echo -e "\nUptime:"
uptime | awk -F', ' '{print $1}'

# Load Average
echo -e "\nLoad Average (1, 5, 15 min):"
uptime | awk '{print $(NF-2), $(NF-1), $NF}'

# Logged-in Users
echo -e "\nLogged-in Users:"
who
