# scoop

> URL: [Scoop](https://scoop.sh/)

## 安装

```bash
# Windows PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

### OR

irm get.scoop.sh | iex

# 自定义安装路径
$env:SCOOP='D:\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
irm get.scoop.sh | iex
```

## 常用库推荐

- `extras`: 最常用的库，包含大量 GUI 软件。
- `versions`: 包含软件的历史版本（如 python37）。

```bash
scoop bucket add extras
scoop bucket add versions
```

## 切换软件版本
```bash
scoop reset python27
```

## 固定软件版本 (禁止更新)

```bash
scoop hold <app>
# 如果想恢复更新
scoop unhold <app>
```

## 清理旧版本缓存

```bash
# 查看可以清理的内容
scoop cleanup
# 清理所有软件的旧版本
scoop cleanup *
# 清理下载包缓存 (cache)
scoop cache rm *
```

## 个人常用包

```bash
scoop liist

>>>>>

7zip   26.00
cacert 2026-03-19
make   4.4.1
nodejs 22.19.0
pnpm   10.28.2
task   3.50.0
unzip  6.00
wget   1.21.4
zip    3.0
```

## 常见问题处理

- 权限报错：Scoop 默认不需要管理员权限。如果遇到权限问题，请确认你是否在尝试使用 -g 全局安装，或者该目录是否被杀毒软件锁定。
- 连接超时：由于 GitHub 访问不稳定，建议为 Git 设置代理，或在 PowerShell 环境中设置 HTTP_PROXY。
