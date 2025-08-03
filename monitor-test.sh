#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
URL="https://test.com/monitoring/test/api"
LAST_PID_FILE="/tmp/.last_test_pid"

PID=$(pgrep -x "$PROCESS_NAME")

if [ -z "$PID" ]; then
    exit 0
fi

if [ -f "$LAST_PID_FILE" ]; then
    LAST_PID=$(cat "$LAST_PID_FILE")
    if [ "$LAST_PID" != "$PID" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Process $PROCESS_NAME restarted. Old PID: $LAST_PID, New PID: $PID" >> "$LOG_FILE"
    fi
fi

echo "$PID" > "$LAST_PID_FILE"

curl -s --connect-timeout 5 --max-time 10 "$URL" > /dev/null
if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Server $URL is not available." >> "$LOG_FILE"
fi
