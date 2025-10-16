#!/bin/bash
# Ротация SSH ключей для безопасности

set -euo pipefail

echo "🔄 Ротация SSH ключей"
echo "===================="

# Создание нового ключа
NEW_KEY_NAME="id_rsa_$(date +%Y%m%d_%H%M%S)"
ssh-keygen -t rsa -b 4096 -C "devops@cloudsre.xyz" -f ~/.ssh/github/${NEW_KEY_NAME} -N ""

echo "✅ Новый SSH ключ создан: ${NEW_KEY_NAME}"
echo ""
echo "📋 Следующие шаги:"
echo "1. Добавить новый ключ в GitHub:"
echo "   cat ~/.ssh/github/${NEW_KEY_NAME}.pub"
echo ""
echo "2. Протестировать новый ключ:"
echo "   ssh -T git@github.com -i ~/.ssh/github/${NEW_KEY_NAME}"
echo ""
echo "3. Обновить SSH config:"
echo "   IdentityFile ~/.ssh/github/${NEW_KEY_NAME}"
echo ""
echo "4. Удалить старый ключ из GitHub"
echo "5. Удалить старый ключ:"
echo "   rm ~/.ssh/github/id_rsa*"
echo "   mv ~/.ssh/github/${NEW_KEY_NAME} ~/.ssh/github/id_rsa"
echo "   mv ~/.ssh/github/${NEW_KEY_NAME}.pub ~/.ssh/github/id_rsa.pub"
