# Oshtuk — Monitoring Script

Мониторинг процесса `test` с логированием и HTTPS-запросом.

## Возможности:
- Проверка процесса каждую минуту.
- Запрос к https://test.com/monitoring/test/api если работает.
- Лог в `/var/log/monitoring.log`, если перезапущен или сервер недоступен.

## Установка:

```bash
sudo cp monitor-test.service /etc/systemd/system/
sudo cp monitor-test.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable monitor-test.timer
sudo systemctl start monitor-test.timer
