#!/bin/bash
echo "📊 Статус DevOps стека:"
echo "======================"
docker-compose ps
echo ""
echo "💾 Использование ресурсов:"
docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"
echo ""
echo "🔍 Проверка доступности сервисов:"
for service in prometheus grafana loki postgres redis minio vault gotify jenkins; do
    if curl -s http://localhost:$(docker-compose port $service 2>/dev/null | cut -d: -f2) >/dev/null 2>&1; then
        echo "✅ $service: доступен"
    else
        echo "❌ $service: недоступен"
    fi
done
