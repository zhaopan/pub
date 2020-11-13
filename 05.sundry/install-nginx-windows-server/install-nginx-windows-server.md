# install-nginx-windows-server

## 步骤

***Windows Service Wrapper***

- 工具：https://github.com/kohsuke/winsw/releases
- nginx：http://nginx.org/download/

- copy nginx-1.12.2 至本地电脑
- 在cmd中运行如下命令安装windows服务
- 管理员身份运行
- D:\tools\nginx-1.12.2\nginx-service.exe install
- 即可通过windows 服务窗口来管理nginx服务

ps
```bash
# 一般卸载后..刷新一下服务列表就会消失不见..但是也会偶尔碰上一些钉子户..
# 这时候其实重启一下机器就可以解决这个问题..会被回收掉..但是在服务器上..可不是随便都能重启的..
# 这就到祭出杀手锏的时候了..
# 删注册表..
# 步骤:
# Win+R
# regedit
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services
# 路径下找到你的服务名..直接Delete  确定..
# 刷新服务列表..不见啦..
# 搞定..
```
