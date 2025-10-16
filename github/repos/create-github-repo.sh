#!/bin/bash
# Создание GitHub repository для DevOps стека

set -euo pipefail

echo "🐙 Создание GitHub Repository"
echo "============================="

# Проверка GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI не установлен"
    echo "Установите: https://cli.github.com/"
    exit 1
fi

# Проверка авторизации
if ! gh auth status &> /dev/null; then
    echo "🔐 Авторизация в GitHub..."
    gh auth login
fi

# Создание repository
echo "📦 Создание repository..."
gh repo create devops-stack \
    --public \
    --description "Production-ready DevOps stack with monitoring, security, and automation" \
    --add-readme \
    --clone

echo "✅ Repository создан: https://github.com/$(gh api user --jq .login)/devops-stack"
echo ""
echo "🔧 Следующие шаги:"
echo "1. cd devops-stack"
echo "2. git remote add origin https://github.com/$(gh api user --jq .login)/devops-stack.git"
echo "3. git add ."
echo "4. git commit -m 'Initial commit'"
echo "5. git push -u origin main"
echo "6. Настроить secrets в GitHub Settings > Secrets and variables > Actions"
