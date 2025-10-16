#!/bin/bash
# Клонирование GitHub repository с SSH

set -euo pipefail

echo "🐙 Клонирование GitHub Repository"
echo "================================"

# Получение username
read -p "Введите ваш GitHub username: " github_username

# Клонирование repository
if [ -d "devops-stack" ]; then
    echo "Директория devops-stack уже существует"
    cd devops-stack
    git remote -v
else
    echo "Клонирование repository..."
    git clone git@github.com:${github_username}/devops-stack.git
    cd devops-stack
fi

# Проверка SSH соединения
echo "Проверка SSH соединения..."
ssh -T git@github.com

echo "✅ Repository готов к работе!"
echo ""
echo "Следующие команды:"
echo "git add ."
echo "git commit -m 'Initial commit'"
echo "git push origin main"
