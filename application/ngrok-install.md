# ngrok 自定义安装

## golang[下载地址](http://www.golangtc.com/download)

```bash
cd ~/
wget http://www.golangtc.com/static/go/1.8/go1.8.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.8.linux-amd64.tar.gz
```

## 环境变量设置

```bash
mkdir $HOME/go
echo 'export GOROOT=/usr/local/go'>> ~/.bashrc
echo 'export GOPATH=$HOME/go'>> ~/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin'>> ~/.bashrc
source $HOME/.bashrc
```

## go语言安装环境

```bash
yum install mercurial git bzr subversion
```

## 下载最新的ngrok，不需要修改任何代码

```bash
git clone https://github.com/inconshreveable/ngrok.git
```

## 设置你要绑定的域名

```bash
export NGROK_DOMAIN="tunnel.xx.com" #设置你要绑定的域名
```

```bash
cd ngrok
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
openssl genrsa -out device.key 2048
openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
cp rootCA.pem assets/client/tls/ngrokroot.crt -i
cp device.crt assets/server/tls/snakeoil.crt -i
cp device.key assets/server/tls/snakeoil.key -i
```

## 编译linux服务端

```bash
GOOS=linux GOARCH=amd64 make release-server
```

## 编译linux客户端

```bash
GOOS=linux GOARCH=amd64 make release-client
```

## 解决下面的错误

```bash
cd /usr/local
cp -rf go go1.4
```

## 编译windows客户端之前的go配置

```bash
cd go/src
GOOS=windows GOARCH=amd64 CGO_ENABLED=0 ./make.bash
```

## 编译windows客户端

```bash
cd ~/go/ngrok
GOOS=windows GOARCH=amd64 make release-client
```

## 启动服务端

```bash
#linux.sh

ngrokd -log=ngrok_log.txt -domain="tunnel.xx.com" -httpAddr=":8000" #注意$NGROK_DOMAIN在系统重启后会释放这个值，所以用常量
```

## windows配置文件

`示例:windows配置文件`

```bash
#ngrok-test.yml 单独映射
server_addr: "tunnel.xx.com:4443"
trust_host_root_certs: false
```

```bash
#ngrok-git-api.yml 批量映射
server_addr: "tunnel.xx.com:4443"
trust_host_root_certs: false
tunnels:
  git:
    subdomain: git
    proto:
      http: 8000
  api:
    subdomain: api
    proto:
      http: 8000
```

## 启动windows客户端

`示例:windows启动`

```bash
bin #ngrokd文件夹
conf #配置文件夹
    ngrok-test.yml #单独启动
    ngrok-git-api.yml #批量启动
logs
    ...#日志文件
start-test.bat #bat启动文件-单独
start-git-api.bat #bat启动文件-批量启动
```

```bash
#start-test.bat 单独启动
bin\ngrok -config=ngrok-test.yml -log=logs\ngrok_log.txt -subdomain=test 80
```

```bash
#start-git-api.bat 批量启动
bin\ngrok -config=conf\ngrok-git-api.yml -log=logs\ngrok_log.txt start api git
```

`注意:`

**检查端口占用**:

**CENTOS防火墙配置**:

```bash
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 4443 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 8000 -j ACCEPT
iptables save
service iptables restart
```

**阿里云安全组设置**:

- 添加->8000 入口
- 添加<-4443 出口

**本地端口检查**:

- 1：检查端口占用</br>
- 2：开启端口:->80</br>
- 3：开启端口:<-4443</br>

**代理转发-支持80端口**:

**apache代理转发**:

- 若只有自己使用，在apache添加如下;</br>
- 没必要去折腾成nginx，虽然理论上支持无限个二级域名；

```xml
<VirtualHost *:80>
  ServerAdmin admin@xx.com
  ServerAlias upal.tunnel.xx.com
  ProxyPass / http://upal.tunnel.xx.com:8000/
  ProxyPassReverse / http://upal.tunnel.xx.com:8000/
  ErrorLog "/data/wwwlogs/ngrok_wx_error_apache.log"
  CustomLog "/data/wwwlogs/ngrok_wx_apache.log" common
</VirtualHost>
```

***nginx代理转发请看*** [cxz001](https://my.oschina.net/cxz001/blog/784620)

参考链接：
[golang](https://github.com/golang/go)
[ngrok](https://github.com/inconshreveable/ngrok)
[ngrok-docs](https://ngrok.com/docs)
[bbear](http://bbear.me/shi-yong-a-li-yun-da-jian-zi-ji-de-ngrokfu-wu)
[cxz001](https://my.oschina.net/cxz001/blog/784620)
