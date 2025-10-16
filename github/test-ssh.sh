#!/bin/bash
# Тестирование SSH соединения с GitHub

echo "🧪 Тестирование SSH соединения"
echo "=============================="

# Тест 1: SSH соединение
echo "1. Тестирование SSH соединения..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ SSH соединение работает"
else
    echo "❌ SSH соединение не работает"
    echo "Убедитесь, что ключ добавлен в GitHub"
fi

# Тест 2: Git операции
echo ""
echo "2. Тестирование Git операций..."
if git ls-remote git@github.com:octocat/Hello-World.git > /dev/null 2>&1; then
    echo "✅ Git операции работают"
else
    echo "❌ Git операции не работают"
fi

# Тест 3: SSH agent
echo ""
echo "3. Тестирование SSH agent..."
if ssh-add -l > /dev/null 2>&1; then
    echo "✅ SSH agent работает"
    echo "Загруженные ключи:"
    ssh-add -l
else
    echo "❌ SSH agent не работает"
fi

echo ""
echo "🎯 Все тесты завершены!"
