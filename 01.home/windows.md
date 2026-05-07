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

![CredSSP](https://fkwar.oss-cn-beijing.aliyuncs.com/813569BB-E5A9-494C-AE24-03F76B9D8C89.png)

_**解决方法**_

* 1.运行 gpedit.msc
* 2.计算机配置&gt;管理模板&gt;系统&gt;凭据分配&gt;加密Oracle修正
* 3.选择启用并选择易受攻击.

## Docker Desktop安装失败

![CredSSP](https://fkwar.oss-cn-beijing.aliyuncs.com/24a3e874-fdff-48a6-80b5-76f90057f6a7.png)

_**解决方法**_

### 方案 A：删除旧目录（最推荐）

- 打开文件资源管理器，定位到 C:\ProgramData（这是一个隐藏文件夹，如果看不到，请在地址栏直接输入路径）。
- 找到 DockerDesktop 文件夹。
- 删除该文件夹。如果无法删除，请重启电脑后再试。
- 重新运行安装程序。

### 方案 B：手动修正所有权（如果不想删除）

- 右键点击 C:\ProgramData\DockerDesktop 文件夹，选择属性。
- 点击安全选项卡 -> 高级。
- 在"所有者"旁边点击更改。
- 分别输入 SYSTEM 和 Administrators，点击"检查名称"并确定。
- 勾选"替换子容器和对象的所有者"，点击确定应用。

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
# 强制(/F参数)杀死 pid 为 9088 的所有进程包括子进程(/T参数):
taskkill /T /F /PID 9088
```
## 系统重装后 SID 不一致

现象:无法删除文件或文件夹

PowerShell-admin

```PowerShell
# 1. 强制夺取所有权
takeown /f "你的文件夹或文件路径" /r /d y

# 2. 重置 ACL,抹掉旧系统的 SID 记录
# /reset 会移除所有旧的、无效的 ACE(访问控制条目)
icacls "你的文件夹或文件路径" /reset /t /c /l
```

## 重设pem文件权限

```bash
# PowerShell

# 1. 进入密钥所在的目录
cd "e:\sync\Dropbox\.ssh\"

# 2. 循环处理所有 .pem 文件
Get-ChildItem * | ForEach-Object {
    $path = $_.FullName

    # 禁用权限继承，并移除所有已继承的权限
    icacls $path /inheritance:r

    # 只授予当前登录用户读取和写入权限
    icacls $path /grant:r "${env:USERNAME}:(R,W)"

    Write-Host "已修复权限: $path" -ForegroundColor Green
}
```

## 清理Windows.old

- 按下 Win + R,输入 cleanmgr 并回车.
- 选择 C 盘,点击确定.
- 在弹出的窗口中,务必点击底部的 "清理系统文件" 按钮(需要管理员权限).
- 再次选择 C 盘,系统会重新扫描.
- 在列表中找到并勾选 "以前的 Windows 安装".
- 点击确定,系统会安全地卸载这些过时组件.
