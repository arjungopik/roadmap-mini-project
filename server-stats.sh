#!/bin/bash

echo "========================================"
echo "        SERVER PERFORMANCE STATS        "
echo "========================================"
echo ""

# ----------------------------------------
# CPU Usage
# ----------------------------------------
echo "🔹 Total CPU Usage:"
CPU_IDLE=$(top -bn1 | awk -F',' '/Cpu/ {print $4}' | awk '{print $1}')
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)
echo "CPU Usage: $CPU_USAGE %"
echo ""

# ----------------------------------------
# Memory Usage
# ----------------------------------------
echo "🔹 Memory Usage:"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')

echo "Total: ${MEM_TOTAL} MB"
echo "Used : ${MEM_USED} MB"
echo "Free : ${MEM_FREE} MB"
echo "Usage: ${MEM_PERCENT} %"
echo ""

# ----------------------------------------
# Disk Usage (Root Partition)
# ----------------------------------------
echo "🔹 Disk Usage (/ partition):"
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "Total: $DISK_TOTAL"
echo "Used : $DISK_USED"
echo "Free : $DISK_FREE"
echo "Usage: $DISK_PERCENT"
echo ""

# ----------------------------------------
# Top 5 Processes by CPU
# ----------------------------------------
echo "🔹 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo ""

# ----------------------------------------
# Top 5 Processes by Memory
# ----------------------------------------
echo "🔹 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
echo ""

# ----------------------------------------
# Stretch Goals
# ----------------------------------------
echo "🔹 OS Version:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo ""

echo "🔹 Uptime:"
uptime -p
echo ""

echo "🔹 Load Average:"
uptime | awk -F'load average:' '{print $2}'
echo ""

echo "🔹 Logged-in Users:"
who
echo ""

echo "🔹 Last 5 Failed Login Attempts:"
if command -v lastb &> /dev/null; then
    lastb | head -n 5
else
    echo "lastb command not available"
fi
echo ""

echo "========================================"
echo "              END OF REPORT             "
echo "========================================"