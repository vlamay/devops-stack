# 🚀 Cloudflare DevOps Stack Deployment Guide

## 📋 Prerequisites

### 1. Server Requirements
- Ubuntu 20.04+ or similar
- 4GB RAM minimum
- 50GB storage
- Public IP address
- Domain names configured

### 2. Cloudflare Account
- Active Cloudflare account
- Domain added to Cloudflare
- DNS management access
- SSL/TLS settings access

## 🔧 Step-by-Step Deployment

### Step 1: Server Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Nginx
sudo apt install -y nginx

# Install Certbot
sudo apt install -y certbot
```

### Step 2: DevOps Stack Deployment
```bash
# Clone or copy DevOps stack
cd ~/devops-stack

# Start the stack
docker-compose up -d

# Verify services
./monitor-stack.sh
```

### Step 3: Nginx Configuration
```bash
# Copy Nginx configuration
sudo cp ~/devops-stack/cloudflare/nginx/nginx.conf /etc/nginx/nginx.conf

# Test configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
```

### Step 4: SSL Certificates
```bash
# Run SSL setup
~/devops-stack/cloudflare/ssl/setup-ssl.sh

# Verify certificates
sudo certbot certificates
```

### Step 5: Cloudflare DNS Configuration
1. Login to Cloudflare dashboard
2. Select your domain
3. Go to DNS settings
4. Add A records pointing to your server IP
5. Enable Cloudflare proxy (orange cloud)

### Step 6: Cloudflare SSL Settings
1. Go to SSL/TLS settings
2. Set encryption mode to "Full (strict)"
3. Enable "Always Use HTTPS"
4. Enable "HTTP Strict Transport Security (HSTS)"

## 🔍 Verification

### Check Services
```bash
# Check Docker containers
docker ps

# Check Nginx
sudo systemctl status nginx

# Check SSL certificates
sudo certbot certificates
```

### Test URLs
- https://cloudsre.xyz (Grafana dashboard)
- https://monitoring.cloudsre.xyz (Monitoring)
- https://vault.cloudsre.xyz (Vault)
- https://trustforge.uk (Security dashboard)

## 🚨 Troubleshooting

### Common Issues

#### 1. SSL Certificate Issues
```bash
# Renew certificates
sudo certbot renew

# Check certificate status
sudo certbot certificates
```

#### 2. Nginx Configuration Issues
```bash
# Test configuration
sudo nginx -t

# Check logs
sudo tail -f /var/log/nginx/error.log
```

#### 3. Docker Issues
```bash
# Check container logs
docker-compose logs -f

# Restart services
docker-compose restart
```

#### 4. DNS Issues
- Verify DNS records in Cloudflare
- Check DNS propagation
- Test with different DNS servers

## 📊 Monitoring

### Health Checks
```bash
# Check all services
curl -I https://cloudsre.xyz
curl -I https://trustforge.uk

# Check specific services
curl -I https://monitoring.cloudsre.xyz
curl -I https://vault.cloudsre.xyz
```

### Logs
```bash
# Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Docker logs
docker-compose logs -f
```

## 🎯 Production Checklist

- [ ] Server hardened
- [ ] SSL certificates installed
- [ ] Nginx configured
- [ ] Docker stack running
- [ ] DNS records configured
- [ ] Cloudflare settings optimized
- [ ] Monitoring configured
- [ ] Backups configured
- [ ] Security scanning enabled
- [ ] Performance optimized

## 💰 Monetization Ready

Once deployed, you can:
1. Offer managed services
2. Provide monitoring dashboards
3. Sell security services
4. Offer consulting
5. Create SaaS products

## 🎉 Success!

Your Cloudflare DevOps stack is now ready for production use and monetization!
