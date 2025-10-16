# DNS Setup for trustforge.uk

## A Records
- @ (root) -> YOUR_SERVER_IP
- www -> YOUR_SERVER_IP
- api -> YOUR_SERVER_IP
- security -> YOUR_SERVER_IP
- vault -> YOUR_SERVER_IP
- monitoring -> YOUR_SERVER_IP

## CNAME Records
- devops -> trustforge.uk
- logs -> trustforge.uk
- alerts -> trustforge.uk

## TXT Records
- @ -> "v=spf1 include:_spf.cloudflare.com ~all"
- @ -> "google-site-verification=YOUR_VERIFICATION_CODE"

## MX Records
- @ -> mail.trustforge.uk (priority 10)
