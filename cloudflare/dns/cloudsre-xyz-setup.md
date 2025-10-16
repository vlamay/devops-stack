# DNS Setup for cloudsre.xyz

## A Records
- @ (root) -> YOUR_SERVER_IP
- www -> YOUR_SERVER_IP
- api -> YOUR_SERVER_IP
- monitoring -> YOUR_SERVER_IP
- grafana -> YOUR_SERVER_IP
- prometheus -> YOUR_SERVER_IP
- vault -> YOUR_SERVER_IP
- notifications -> YOUR_SERVER_IP
- storage -> YOUR_SERVER_IP

## CNAME Records
- devops -> cloudsre.xyz
- logs -> cloudsre.xyz
- alerts -> cloudsre.xyz

## TXT Records
- @ -> "v=spf1 include:_spf.cloudflare.com ~all"
- @ -> "google-site-verification=YOUR_VERIFICATION_CODE"

## MX Records
- @ -> mail.cloudsre.xyz (priority 10)
