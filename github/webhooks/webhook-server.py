#!/usr/bin/env python3
"""
GitHub Webhook Server для DevOps стека
Обрабатывает webhooks от GitHub и запускает соответствующие действия
"""

import json
import hmac
import hashlib
import subprocess
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs

class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        """Обработка POST запросов от GitHub"""
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        # Проверка подписи webhook
        if not self.verify_signature(post_data):
            self.send_response(401)
            self.end_headers()
            return
        
        # Парсинг JSON
        try:
            payload = json.loads(post_data.decode('utf-8'))
        except json.JSONDecodeError:
            self.send_response(400)
            self.end_headers()
            return
        
        # Обработка различных типов событий
        event_type = self.headers.get('X-GitHub-Event')
        
        if event_type == 'push':
            self.handle_push(payload)
        elif event_type == 'pull_request':
            self.handle_pull_request(payload)
        elif event_type == 'release':
            self.handle_release(payload)
        elif event_type == 'workflow_run':
            self.handle_workflow_run(payload)
        else:
            print(f"Неизвестный тип события: {event_type}")
        
        self.send_response(200)
        self.end_headers()
    
    def verify_signature(self, payload):
        """Проверка подписи webhook"""
        signature = self.headers.get('X-Hub-Signature-256')
        if not signature:
            return False
        
        secret = os.getenv('GITHUB_WEBHOOK_SECRET', 'your-webhook-secret')
        expected_signature = 'sha256=' + hmac.new(
            secret.encode('utf-8'),
            payload,
            hashlib.sha256
        ).hexdigest()
        
        return hmac.compare_digest(signature, expected_signature)
    
    def handle_push(self, payload):
        """Обработка push событий"""
        branch = payload['ref'].replace('refs/heads/', '')
        repository = payload['repository']['full_name']
        
        print(f"Push в {repository} на ветку {branch}")
        
        if branch == 'main':
            self.deploy_production()
        elif branch == 'develop':
            self.deploy_staging()
    
    def handle_pull_request(self, payload):
        """Обработка pull request событий"""
        action = payload['action']
        pr_number = payload['pull_request']['number']
        
        print(f"Pull Request #{pr_number} {action}")
        
        if action in ['opened', 'synchronize']:
            self.run_tests()
        elif action == 'closed' and payload['pull_request']['merged']:
            self.merge_to_main()
    
    def handle_release(self, payload):
        """Обработка release событий"""
        action = payload['action']
        tag_name = payload['release']['tag_name']
        
        print(f"Release {action}: {tag_name}")
        
        if action == 'published':
            self.deploy_release(tag_name)
    
    def handle_workflow_run(self, payload):
        """Обработка workflow run событий"""
        workflow_run = payload['workflow_run']
        status = workflow_run['status']
        conclusion = workflow_run['conclusion']
        
        print(f"Workflow run: {status} - {conclusion}")
        
        if status == 'completed' and conclusion == 'success':
            self.notify_success()
        elif status == 'completed' and conclusion == 'failure':
            self.notify_failure()
    
    def deploy_production(self):
        """Развертывание в production"""
        print("🚀 Развертывание в production...")
        subprocess.run(['/home/devops/devops-stack/deploy-production.sh'])
    
    def deploy_staging(self):
        """Развертывание в staging"""
        print("🧪 Развертывание в staging...")
        subprocess.run(['/home/devops/devops-stack/deploy-staging.sh'])
    
    def run_tests(self):
        """Запуск тестов"""
        print("🧪 Запуск тестов...")
        subprocess.run(['/home/devops/devops-stack/run-tests.sh'])
    
    def merge_to_main(self):
        """Слияние в main"""
        print("🔄 Слияние в main...")
        subprocess.run(['/home/devops/devops-stack/merge-to-main.sh'])
    
    def deploy_release(self, tag_name):
        """Развертывание release"""
        print(f"📦 Развертывание release {tag_name}...")
        subprocess.run(['/home/devops/devops-stack/deploy-release.sh', tag_name])
    
    def notify_success(self):
        """Уведомление об успехе"""
        print("✅ Уведомление об успехе...")
        subprocess.run(['/home/devops/devops-stack/notify-success.sh'])
    
    def notify_failure(self):
        """Уведомление о неудаче"""
        print("❌ Уведомление о неудаче...")
        subprocess.run(['/home/devops/devops-stack/notify-failure.sh'])

def main():
    """Запуск webhook сервера"""
    port = int(os.getenv('WEBHOOK_PORT', 8080))
    server = HTTPServer(('0.0.0.0', port), WebhookHandler)
    
    print(f"🌐 Webhook сервер запущен на порту {port}")
    print(f"📡 Ожидание webhooks от GitHub...")
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n🛑 Остановка webhook сервера...")
        server.shutdown()

if __name__ == '__main__':
    main()
