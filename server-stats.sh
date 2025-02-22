#!/bin/bash

# Function for macOS stats
macos_stats() {
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
}

# Function for Linux stats
linux_stats() {

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
}

# Function for Windows stats
windows_stats() {
    
    echo "Running Windows version..."
    
    # CPU Usage
    echo "CPU Usage:"
    powershell -Command "Get-WmiObject win32_processor | select LoadPercentage"
    
    # Memory Usage
    echo "Memory Usage:"
    powershell -Command "Get-WmiObject Win32_OperatingSystem | select TotalVisibleMemorySize,FreePhysicalMemory"
    
    # Disk Usage
    echo "Disk Usage:"
    powershell -Command "Get-WmiObject Win32_LogicalDisk | select DeviceID, MediaType, @{Name='Used(GB)'; Expression={($_.Size - $_.FreeSpace)/1GB}}, @{Name='Free(GB)'; Expression={($_.FreeSpace)/1GB}}"

    # Top Processes (CPU Usage)
    echo "Top 5 Processes by CPU Usage:"
    powershell -Command "Get-Process | Sort-Object CPU -Descending | Select-Object -First 5"
    
    # Top Processes (Memory Usage)
    echo "Top 5 Processes by Memory Usage:"
    powershell -Command "Get-Process | Sort-Object WS -Descending | Select-Object -First 5"

    # OS Version
    echo "OS Version:"
    powershell -Command "Get-WmiObject Win32_OperatingSystem | select Caption"
    
    # Uptime
    echo "Uptime:"
    powershell -Command "(Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime"
    
    # Load Average (This is a workaround as Windows doesn't report load average in the same way)
    echo "System Uptime (for a rough idea of load average):"
    powershell -Command "(Get-Uptime)"
}

# Main script logic to detect OS and call the appropriate function
OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "Linux" ]]; then
    linux_stats
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    macos_stats
elif [[ "$OS_TYPE" == "CYGWIN" || "$OS_TYPE" == "MINGW" ]]; then
    windows_stats
else
    echo "Unsupported OS: $OS_TYPE"
fi
