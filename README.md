# Server-Performance-Stats
script to analyse basic server performance stats.
## DevOps Roadmap
This project is part of the DevOps roadmap. You can explore more about this in the DevOps Roadmap.

https://roadmap.sh/projects/server-stats

# Server Stats Script

This repository contains a set of scripts to monitor and display key system statistics for different operating systems. Currently, the script supports Windows, Linux, and macOS. It gathers information such as CPU usage, memory usage, disk usage, top processes, OS version, uptime, and more.

## Functions

Each operating system has a corresponding script that collects and displays relevant statistics. The scripts for each OS are modular, meaning that you can easily add new ones or update the existing ones.

### Windows Stats (`windows_stats` function)
This function collects system statistics from Windows OS using PowerShell. It includes:

- **CPU Usage**: The percentage of CPU load.
- **Memory Usage**: Total visible memory and free physical memory.
- **Disk Usage**: Disk information including device ID, media type, used space, and free space.
- **Top Processes by CPU Usage**: Displays the top 5 processes consuming the most CPU.
- **Top Processes by Memory Usage**: Displays the top 5 processes consuming the most memory.
- **OS Version**: Displays the version of the Windows OS.
- **Uptime**: Displays the last boot time of the system.
- **System Uptime**: A rough metric for load average based on the system uptime.

### Linux Stats (`linux_stats` function)
This function collects system statistics for Linux-based operating systems. It uses commands like `top`, `free`, and `df` to gather the following information:

- **CPU Usage**: User, system, and idle CPU usage percentages.
- **Memory Usage**: Total, used, and free memory.
- **Disk Usage**: Disk space usage for each mounted filesystem.
- **Top Processes by CPU Usage**: Displays the top 5 processes consuming the most CPU.
- **Top Processes by Memory Usage**: Displays the top 5 processes consuming the most memory.
- **OS Version**: Displays the version of the Linux OS.
- **Uptime**: Displays the system's uptime.
- **Load Average**: The system's load average for 1, 5, and 15 minutes.

### macOS Stats (`mac_stats` function)
This function collects system statistics for macOS-based operating systems. It uses commands like `top`, `df`, and `sysctl` to gather:

- **CPU Usage**: User, system, and idle CPU usage percentages.
- **Memory Usage**: Total, used, and free memory.
- **Disk Usage**: Disk space usage for each mounted filesystem.
- **Top Processes by CPU Usage**: Displays the top 5 processes consuming the most CPU.
- **Top Processes by Memory Usage**: Displays the top 5 processes consuming the most memory.
- **OS Version**: Displays the macOS version.
- **Uptime**: Displays the system's uptime.
- **Load Average**: The system's load average for 1, 5, and 15 minutes.

## Initialization and Running the Script

### Step 1: Clone the repository

To get started, clone the repository to your local machine:

```bash
git clone https://github.com/MarcosReyero/Server-Performance-Stats.git
cd Server-Performance-Stats
```


### Step 2: Initialize the `server-stats.sh` script

The `server-stats.sh` script acts as the initializer and decides which script to run based on the operating system detected. It will run the corresponding stats script depending on whether you're using Windows, Linux, or macOS.

### Make sure the script is executable:

#### On Linux/macOS:

```bash
chmod +x server-stats.sh
```

### Run the script:
For Linux or macOS:
```bash
./server-stats.sh
```
On Windows, open PowerShell as administrator and run:
```bash
.\server-stats.ps1
```
