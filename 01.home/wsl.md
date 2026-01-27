# wsl

## 确认已安装的分发版
wsl -l -v

# 进入 Debian
wsl -d Debian

# 查找官方支持的名称
wsl --list --online

# 安装 Debian
wsl --install -d Debian

# 设置 wsl 默认节点
wsl --set-default Debian

## 导出
wsl --export Debian E:\backups\debian-backup-2026-01.tar

## 导入
wsl --import Debian E:\data\wsl\Debian E:\backups\debian-backup-2026-01.tar

## 关闭WSL实例
wsl --shutdown

## 卸载
wsl --unregister Debian
