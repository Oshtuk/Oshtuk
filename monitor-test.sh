#!/bin/bash

LOGFILE="/var/log/monitoring.log"
PROCESS="test"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

status=$(systemctl is-active "$PROCESS")

if [ "$status" = "active" ]; then
    echo "$TIMESTAMP - $PROCESS is running" >> "$LOGFILE"
else
    echo "$TIMESTAMP - $PROCESS was stopped or failed, restarting..." >> "$LOGFILE"
    systemctl restart "$PROCESS"
fi
