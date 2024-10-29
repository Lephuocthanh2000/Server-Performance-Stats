#!/bin/bash

echo "===== Server Performance Stats ====="

# Total CPU usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Usage: " $2 + $4 "%"}'

# Total memory usage
echo -e "\nMemory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2}'

# Total disk usage
echo -e "\nDisk Usage:"
df -h --total | awk '$NF=="total"{printf "Used: %s, Free: %s (%.2f%%)\n", $3, $4, $5}'

# Top 5 processes by CPU usage
echo -e "\nTop 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | head -n 6 | awk '{print $1, $2, $3, $4, $11}'

# Top 5 processes by memory usage
echo -e "\nTop 5 Processes by Memory Usage:"
ps aux --sort=-%mem | head -n 6 | awk '{print $1, $2, $3, $4, $11}'

# Stretch goal: Additional stats
echo -e "\n===== Additional System Info ====="

# OS version
echo "OS Version:"
lsb_release -a 2>/dev/null || cat /etc/os-release

# System uptime
echo -e "\nSystem Uptime:"
uptime -p

# Load average
echo -e "\nLoad Average (1, 5, 15 minutes):"
uptime | awk -F'load average:' '{ print $2 }'

# Logged-in users
echo -e "\nLogged-in Users:"
who

# Failed login attempts
echo -e "\nFailed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l 2>/dev/null || echo "Log file not found or permission denied"
