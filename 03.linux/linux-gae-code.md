# linux-gae-code

## git获取代码

```bash
gcloud config set project gaenodes
gcloud source repos clone default ~/src/gaenodes/default
cd ~/src/gaenodes/default
git checkout gcloud
```

## 调试

```bash
dev_appserver.py --php_executable_path=/usr/bin/php-cgi $PWD
```

## 发布

```bash
gcloud app deploy app.yaml
```

