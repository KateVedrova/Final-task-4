#!/bin/bash

# Создаем файл логов
cat <<EOL > access.log
192.168.1.1 - - 28/Jul/2024:12:34:56 +0000 "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - 28/Jul/2024:12:35:56 +0000 "POST /login HTTP/1.1" 200 567
192.168.1.3 - - 28/Jul/2024:12:36:56 +0000 "GET /home HTTP/1.1" 404 890
192.168.1.1 - - 28/Jul/2024:12:37:56 +0000 "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - 28/Jul/2024:12:38:56 +0000 "GET /about HTTP/1.1" 200 432
192.168.1.2 - - 28/Jul/2024:12:39:56 +0000 "GET /index.html HTTP/1.1" 200 1234
EOL

# Подсчитываем общее количество запросов
total_requests=$(wc -l < access.log)

# Подсчитываем количество уникальных IP-адресов с помощью awk
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)

# Подсчитываем количество запросов по методам
method_count=$(awk '{print $6}' access.log | cut -d\" -f2 | sort | uniq -c | sort -rn)

# Находим самый популярный URL с количеством обращений
popular_url=$(awk '{print $7}' access.log | sort | uniq -c | sort -rn | head -n1)

# Создаем отчет в файл report.txt
echo "Отчет по анализу логов" > report.txt
echo "----------------------" >> report.txt
echo "Общее количество запросов: $total_requests" >> report.txt
echo "Количество уникальных IP-адресов: $unique_ips" >> report.txt
echo "Количество запросов по методам:" >> report.txt
echo "$method_count" >> report.txt
echo "Самый популярный URL: $popular_url" >> report.txt

echo "Отчет успешно создан в файле report.txt"
