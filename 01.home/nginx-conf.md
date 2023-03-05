# Nginx Configs

Tip：version: nginx-1.12.2

- [Nginx Configs](#nginx-configs)
  - [nginx/conf/nginx.conf](#nginxconfnginxconf)
  - [nginx/conf/conf.d/default.conf](#nginxconfconfddefaultconf)
  - [nginx/conf.d/gogs.xx.conf](#nginxconfdgogsxxconf)
  - [error](#error)

## nginx/conf/nginx.conf

```bash
user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    keepalive_timeout  65;
    include /etc/nginx/conf.d/*.conf;
}
```

## nginx/conf/conf.d/default.conf

```bash
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        autoindex  on;
    }
}
```

## nginx/conf.d/gogs.xx.conf

```bash
# 简单配置
server {
    listen       80;
    server_name  gogs.xx.com;
    client_max_body_size 50m;
    location / {
        # 一定要注意这里是docker容器的内网地址+端口,以"/"结尾,不然会报错。
        proxy_pass http://gogs:3000/;
        proxy_redirect default;
        proxy_buffer_size 64k;
        proxy_buffers 32 32k;
        proxy_busy_buffers_size 128k;
    }
}

# 复杂配置
server {
    listen       80;
    server_name  gogs.xx.com;
    access_log logs/gogs.xx.com.log;
    location / {
        #一定要注意这里是docker容器的内网地址+端口,以"/"结尾,不然会报错。
        proxy_pass http://172.18.0.3:3000/;
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        client_max_body_size       10m;
        client_body_buffer_size    128k;
        proxy_connect_timeout      70;
        proxy_send_timeout         90;
        proxy_read_timeout         90;
        #proxy_send_lowat           12000;
        proxy_buffer_size          4k;
        proxy_buffers              4 32k;
        proxy_busy_buffers_size    64k;
        #proxy_temp_file_write_size 64k;
    }
}
```

## error

```bash
# eg:
# centos7 nginx=>nginx
# errorStr => failed (13: Permission denied) while connecting to upstream
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setsebool -P httpd_can_network_connect 1
```
