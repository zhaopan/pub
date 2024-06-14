# windows

## 常用命令

```bash
# 用户账户
netplwiz
net user administrator /active:yes #即可用administrator登录
net user administrator /active:no #即不可用administrator登录

# 驱动器加密
manage-bde.exe D: -lock  -fd

# windows 端口转发
netsh interface ipv6 install
netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=80 connectaddress=10.10.0.1 connectport=22

netsh interface portproxy delete v4tov4 listenaddress=127.0.0.1 listenport=80
netsh interface portproxy show v4tov4
```

## CredSSP加密Oracle修正

![CredSSP](https://oss-cn-beijing.aliyuncs.com/813569BB-E5A9-494C-AE24-03F76B9D8C89.png)

_**解决方法**_

* 1.运行 gpedit.msc
* 2.计算机配置&gt;管理模板&gt;系统&gt;凭据分配&gt;加密Oracle修正
* 3.选择启用并选择易受攻击。


## Windows Bash Proxy

```bash
## 设置代理
set http_proxy=http://127.0.0.1:7890
set https_proxy=http://127.0.0.1:7890

## 取消代理
set http_proxy=
set https_proxy=
```

## 端口查询
```shell
# 查找所有运行的端
netstat -ano

# 查看被占用端口对应的 PID
netstat -aon|findstr "8081"

# 查看指定 PID 的进程
tasklist|findstr "9088"

# 结束进程
# 强制（/F参数）杀死 pid 为 9088 的所有进程包括子进程（/T参数）：
taskkill /T /F /PID 9088
```
