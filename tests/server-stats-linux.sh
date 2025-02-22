#!/bin/bash

echo "Running Linux version..."

# Get CPU usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "User: " 100 - $1 "%"}'

# Get Memory usage
echo "Memory Usage:"
free -h | grep Mem | awk '{print "Memory usage: " $3}'

# Get Disk usage
echo "Disk Usage:"
df -h 

# Get Top 5 processes by CPU usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Get Top 5 processes by Memory usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Get OS Version
echo "OS Version:"
lsb_release -a

# Get Uptime
echo "Uptime:"
uptime

# Get Load Average
echo "Load Average (1, 5, 15 min):"
uptime | awk '{print $10, $11, $12}'

# Get Logged-in users
echo "Logged-in Users:"
w
