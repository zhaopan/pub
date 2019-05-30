#Windows remark

## 用户账户

```bash
$netplwiz
$net user administrator /active:yes #即可用administrator登录
$net user administrator /active:no #即不可用administrator登录
```

## 驱动器加密

```bash
manage-bde.exe D: -lock  -fd
```

## windows 端口转发

```bash
$netsh interface ipv6 install
$netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=80 connectaddress=10.10.0.1 connectport=22

$netsh interface portproxy delete v4tov4 listenaddress=127.0.0.1 listenport=80

$netsh interface portproxy show v4tov4
```

## CredSSP加密Oracle修正
![git](http://cdn.fkwar.com/813569BB-E5A9-494C-AE24-03F76B9D8C89.png)

***解决方法***
```bash
# 1.运行 gpedit.msc
# 2.计算机配置>管理模板>系统>凭据分配>加密Oracle修正
# 3.选择启用并选择易受攻击。
```