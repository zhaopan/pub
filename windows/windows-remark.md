# Windows remark

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