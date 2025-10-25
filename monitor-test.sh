#!/bin/bash

LOGFILE="/var/log/monitoring.log"
PROCESS="test"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Проверяем статус systemd сервиса с именем test
status=$(systemctl is-active "$PROCESS")

# Проверка подключения через HTTPS (пример)
URL="https://test.cлoи"

if [ "$status" = "active" ]; then
    # Дополнительно проверка доступа по HTTPS (curl -s -o /dev/null -w "%{http_code}" можно адаптировать)
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    if [ "$http_status" = "200" ]; then
        echo "$TIMESTAMP - $PROCESS is running and HTTP check passed" >> "$LOGFILE"
    else
        echo "$TIMESTAMP - $PROCESS is running but HTTP check failed with code $http_status" >> "$LOGFILE"
    fi
else
    echo "$TIMESTAMP - $PROCESS not running (status: $status), restarting..." >> "$LOGFILE"
    systemctl restart "$PROCESS"
fi
