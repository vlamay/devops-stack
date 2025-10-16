#!/bin/bash
# Автозапуск DevOps стека после перезагрузки

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[i]${NC} $1"; }

# Переходим в директорию стека
cd /home/devops/devops-stack

# Добавляем PATH для docker-compose
export PATH="/home/devops/.local/bin:$PATH"

# Ждем запуска Docker
info "Ожидание запуска Docker..."
while ! docker info >/dev/null 2>&1; do
    sleep 5
done
log "Docker запущен"

# Ждем немного для полной инициализации
sleep 10

# Запускаем DevOps стек
info "Запуск DevOps стека..."
docker-compose up -d

# Ждем запуска сервисов
info "Ожидание запуска сервисов..."
sleep 30

# Проверяем статус
info "Проверка статуса сервисов..."
docker-compose ps

log "DevOps стек запущен автоматически"

# Отправляем уведомление в Gotify (если доступен)
if curl -s http://localhost:8081 >/dev/null 2>&1; then
    curl -X POST "http://localhost:8081/message" \
        -H "Content-Type: application/json" \
        -d '{
            "title": "DevOps Stack",
            "message": "DevOps стек успешно запущен после перезагрузки",
            "priority": 5
        }' >/dev/null 2>&1 || true
fi
