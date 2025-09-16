#!/bin/bash

# Threshold
THRESHOLD=80

# Get disk usage for root filesystem (% only, without % sign)
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Check if usage is greater than threshold
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    # Alarm Action
    echo "CRITICAL: Disk usage is ${USAGE}% on $(hostname) at $(date)" | mail -s "Disk Alert on $(hostname)" youremail@example.com
fi
