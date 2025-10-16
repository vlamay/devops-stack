#!/bin/bash
echo "🧹 Очистка DevOps стека..."
docker-compose down -v
docker system prune -f
echo "✅ Стек очищен!"
