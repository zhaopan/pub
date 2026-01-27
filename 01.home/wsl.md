# wsl

## 常用命令

```bash
# 确认已安装的分发版
wsl -l -v

# 进入 Debian
wsl -d Debian

# 查找官方支持的名称
wsl --list --online

# 安装 Debian
wsl --install -d Debian

# 设置 wsl 默认节点
wsl --set-default Debian

# 导出
wsl --export Debian E:\backups\debian-backup-2026-01.tar

# 导入
wsl --import Debian E:\data\wsl\Debian E:\backups\debian-backup-2026-01.tar

# 关闭WSL实例
wsl --shutdown

# 卸载
wsl --unregister Debian
```

## 互操作

- 从 Debian 调用 Windows 应用
- 直接在 Debian 脚本中调用 `Windows` 的 .exe

```bash
# 在 .bashrc 中
alias chrome='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
```

- 管道符跨界传输
- 将 Linux 命令的结果直接发给 Windows 剪贴板

```bash
cat wallet_address.txt | clip.exe
```

## 镜像模式 (Mirrored Mode)

默认情况下，WSL 使用 NAT 网络，这会导致从外部访问 WSL 服务（或在 WSL 访问公司内网）比较麻烦。
WSL2 现在的镜像模式可以让 WSL 直接共享 Windows 的 IP 地址

- `Windows` 用户目录下 (%USERPROFILE%) `.wslconfig`

```TOML
[wsl2]
# 开启网络镜像模式
networkingMode=mirrored
# 自动同步代理设置（解决开发时 apt/npm 连不上的问题）
autoProxy=true
# 允许从局域网其他设备访问 WSL 里的 Vue Dev Server
hostAddressLoopback=true
# 强制同步 Windows 的 DNS
dnsTunneling=true
```

## 限制资源占用

- `Windows` 用户目录下 (%USERPROFILE%) `.wslconfig`
- 建议保留给 `Windows` 至少 `4GB`

```TOML
[wsl2]
memory=8GB
processors=4
# 启用自动回收内存，当 Linux 进程结束后，及时归还内存给 Windows
autoMemoryReclaim=gradual
```

## 磁盘压缩

- 解决 VHDX 虚胖
- 在 `PowerShell` 中执行

```bash
# 1. 彻底关闭 WSL
wsl --shutdown

# 2. 在 PowerShell 中以管理员身份执行 (只读挂载 -> 压缩 -> 卸载)
mount-vhd -Path "C:\path\to\ext4.vhdx" -ReadOnly
optimize-vhd -Path "C:\path\to\ext4.vhdx" -Mode Full
detach-vhd -Path "C:\path\to\ext4.vhdx"
```

## 快速定位`VHDX`路径

- PowerShell

```bash
# 获取包含 Debian 的注册表项
$guid = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss\*" |
    Where-Object { $_.DistributionName -eq "Debian" }).PSChildName

# 确保拿到的只是 GUID，然后拼接
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss\$guid"
$vhdxPath = (Get-ItemProperty $regPath).BasePath + "\ext4.vhdx"

Write-Host "成功定位 VHDX 路径：" -ForegroundColor Green
$vhdxPath
```

## 为 VHDX 创建软链接

- 给 `ext4.vhdx` 创建一个符号链接 到 `D:\Debian_Disk.vhdx`
- 以后执行 `get-command optimize-vhd` 时，就不需要再写一长串路径了

```bash
# 管理员权限运行 PowerShell
New-Item -ItemType SymbolicLink -Path "D:\Debian_Disk.vhdx" -Target "$vhdxPath" -Force
```

## `diskpart` 压缩

- 管理员权限运行 PowerShell

```bash
# 1. 关闭 WSL
wsl --shutdown

# 2. 启动磁盘工具
diskpart

# 3. 在 diskpart 交互界面依次输入：
# 选择你的虚拟磁盘文件 (刚才找出来的那个路径)
select vdisk file="E:\data\wsl\Debian\ext4.vhdx"

# 以只读模式挂载 (为了安全)
attach vdisk readonly

# 执行压缩
compact vdisk

# 分离并退出
detach vdisk
exit
```
