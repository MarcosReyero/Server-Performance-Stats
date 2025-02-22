#!/bin/bash

echo "Running Windows version..."

# PowerShell commands to get system stats on Windows

# CPU Usage
echo "CPU Usage:"
powershell Get-WmiObject win32_processor | select LoadPercentage

# Memory Usage
echo "Memory Usage:"
powershell Get-WmiObject Win32_OperatingSystem | select TotalVisibleMemorySize,FreePhysicalMemory

# Disk Usage
echo "Disk Usage:"
powershell Get-WmiObject Win32_LogicalDisk | select DeviceID, MediaType, @{Name="Used(GB)"; Expression={($_.Size - $_.FreeSpace)/1GB}}, @{Name="Free(GB)"; Expression={($_.FreeSpace)/1GB}}

# Top Processes (CPU Usage)
echo "Top 5 Processes by CPU Usage:"
powershell Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

# Top Processes (Memory Usage)
echo "Top 5 Processes by Memory Usage:"
powershell Get-Process | Sort-Object WS -Descending | Select-Object -First 5

# OS Version
echo "OS Version:"
powershell Get-WmiObject Win32_OperatingSystem | select Caption

# Uptime
echo "Uptime:"
powershell (Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime

# Load Average (using system uptime)
echo "Load Average (1, 5, 15 min):"
powershell [System.Diagnostics.Stopwatch]::StartNew()
