#!/bin/bash
# SSL Setup для Cloudflare

# Установка certbot
sudo apt update
sudo apt install -y certbot

# Получение SSL сертификатов
sudo certbot certonly --standalone -d cloudsre.xyz -d www.cloudsre.xyz
sudo certbot certonly --standalone -d trustforge.uk -d www.trustforge.uk

# Создание символических ссылок
sudo ln -sf /etc/letsencrypt/live/cloudsre.xyz/fullchain.pem /etc/ssl/certs/cloudsre.xyz.crt
sudo ln -sf /etc/letsencrypt/live/cloudsre.xyz/privkey.pem /etc/ssl/private/cloudsre.xyz.key
sudo ln -sf /etc/letsencrypt/live/trustforge.uk/fullchain.pem /etc/ssl/certs/trustforge.uk.crt
sudo ln -sf /etc/letsencrypt/live/trustforge.uk/privkey.pem /etc/ssl/private/trustforge.uk.key

# Настройка автообновления
echo "0 12 * * * /usr/bin/certbot renew --quiet" | sudo crontab -

echo "SSL сертификаты настроены!"
