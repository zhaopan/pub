# macOS

## time-line

```mermaid
%%{init: { 'logLevel': 'debug', 'theme': 'base', 'gitGraph': {'showBranches': true, 'showCommitLabel':true,'mainBranchOrder': 2,'mainBranchName': 'tag'}} }%%
gitGraph
    branch System
    commit id: "System 1~7"
    branch MacOS
    commit id: "Mac OS 8~9"
    branch MacOSX
    commit id: "Mac OS X 10.0 Cheetah"
    commit id: "Mac OS X 10.1 Puma"
    commit id: "Mac OS X 10.2 Jaguar"
    commit id: "Mac OS X 10.3 Panther"
    commit id: "Mac OS X 10.4 Tiger"
    commit id: "Mac OS X 10.5 Leopard"
    commit id: "Mac OS X 10.6 Snow Leopard"
    commit id: "Mac OS X 10.7 Lion"
    branch OSX
    commit id: "OS X 10.8 Mountain Lion（去掉久远的Mac，体现Mac与iOS的融合）"
    commit id: "OS X 10.9 Mavericks"
    commit id: "OS X 10.10 Yosemite"
    commit id: "OS X 10.11 El Capitan"
    branch macOS
    commit id: "macOS 10.12 Sierra"
    commit id: "macOS 10.13 High Sierra"
    commit id: "macOS 10.14 Mojave"
    commit id: "macOS 10.15 Catalina"
    commit id: "macOS 11.0 Big Sur"
    commit id: "macOS 12.0 Monterey"
    commit id: "macOS Ventura 13.3"
```

## .bashrc .zshrc

`Catalina+` 把 `.bashrc` 换到了 `.zshrc`

若没有 `.zshrc`, 则需要手动创建 ; 反之手动创建 `.bashrc` , 最后再 `source .zshrc或.bashrc`

```bash
touch ~/.zshrc      # Catalina+
# or
touch ~/.bashrc

vim ~/.zshrc :wq    # Catalina+
# or
vim ~/.bashrc :wq

source .zshrc       # Catalina+
# or
source .bashrc
```

## shell-proxy

vim ~/.zshrc `or` vim ~/.bashrc

```bash
function proxy_on() {
    export all_proxy=socks5://127.0.0.1:7890;
    export http_proxy=socks5://127.0.0.1:7890;
    export https_proxy=socks5://127.0.0.1:7890;
    export ftp_proxy=socks5://127.0.0.1:7890;
    export rsync_proxy=socks5://127.0.0.1:7890;
    export no_proxy=localhost,127.0.0.1,localaddress,.localdomain.com;
}

function proxy_off() {
    unset all_proxy;
    unset http_proxy;
    unset https_proxy;
    unset ftp_proxy;
    unset rsync_proxy;
    unset no_proxy;
}
```

其他

```bash
# 启动代理
proxy_on

# 关闭代理
proxy_off

# 测试代理是否生效
curl ip.sb

system_profiler SPNetworkDataType # 获取完整网络配置信息

networksetup -listallnetworkservices # 列举所有网络设备

networksetup -getwebproxy Wi-Fi # 获取特定网络设备的系统代理配置

scutil --proxy # 获取当前已启用的代理配置，是对 system_profiler 的封装
```

## 自定义 alias

vim ~/.zshrc `or` vim ~/.bashrc

eg:

```bash
alias py3='python3 manage.py'
alias foo='~/tools/foo.sh'
alias bar='~/tools/bar.sh'

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
```

## 常用命令

```bash
# 批量删除 .DS_Store
find . -name ".DS_Store"  -depth -exec rm -f '{}' \;
```

## SSH相关

```bash
# 检查ssh是否运行
sudo launchctl list | grep sshd

# 开启 SSH 服务
sudo launchctl load -w /System/Library/LaunchDeamons/ssh.plist

# 关闭 SSH 服务
sudo launchctl unload -w /System/Library/LaunchDeamons/ssh.plist

# SSH 登陆配置
vim /etc/ssh/sshd_config

# 找到 #Authentication，将 PermitRootLogin 参数修改为 yes
PermitRootLogin yes

# SSH pem权限问题
chmod 755 ~
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/*id_rsa
chmod -R 600 ~/Dropbox/.ssh/*id_rsa
chmod -R 600 ~/Dropbox/.ssh/*pem


```

## 显卡切换

```bash
# 强制使用集成显卡
sudo pmset -a GPUSwitch 0

# 强制使用独立显卡
sudo pmset -a GPUSwitch 1

# 自动切换显卡
sudo pmset -a GPUSwitch 2

# 当前显卡的使用状态
pmset -g

gpuswitch对应值，0是集成显卡，1是独立显卡，2是自动切换

# 需要注意的是：
# 1、外接显示器时，无法强制切换成集成显卡，拔掉后才会生效。
# 2、如果当前是强制集成显卡，插入外接显示器，不会识别外接显示器，必须手动切换到自动或者独立显卡模式。
# 也就是说要外接显示器必须使用独显，手掌怕热的同学必须忍着了，这个是最大的遗憾。不过这种场景下一般是固定的办公桌，可以准备个苹果的蓝牙键盘。
```

## macOS修改命令行电脑名

```bash
# 命令行标题
# Last login: Thu Feb 16 01:16:49 on ttys000
# zpx@iMac ~ %

# 获取hostname
scutil --get HostName
> iMac

# 设置hostname为zpx@iMac
scutil --set HostName iMac
>

# 获取LocalHostName
scutil --get LocalHostName
> iMac.local

# 设置LocalHostName
scutil --set LocalHostName xxx
>
```

## 查看端口号

```bash
netstat -atp tcp | grep -i "listen"

sudo lsof -i -P | grep -i "listen"

sudo lsof -i | grep LISTEN

netstat -ap tcp
```

## Finder 显示隐藏文件和文件夹

```bash
# 第一 步：打开「终端」应用程序。

# 第二步：输入如下命令：
defaults write com.apple.finder AppleShowAllFiles -boolean true

killall Finder

# 第三步：按下「Return」键确认。

# 现在你将会在 Finder 窗口中看到那些隐藏的文件和文件夹了。

# 如果你想再次隐藏原本的隐藏文件和文件夹的话，将上述命令替换成
defaults write com.apple.finder AppleShowAllFiles -boolean false

killall Finder
```

## .DS_Store

```bash
# 禁止生成
#打开 “终端” ，复制黏贴下面的命令，回车执行，重启 Mac 即可生效。
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# 恢复生成
defaults delete com.apple.desktopservices DSDontWriteNetworkStores

# 删除
find / -name ".DS_Store" -depth -exec rm {} \;
#
# 或者
#
find <your path> -name ".DS_Store" -depth -exec rm {} \;
```

## 快捷键 shortcuts

本文仅列出常用的快捷键，详细请参考官网 [Mac 键盘快捷键](https://support.apple.com/zh-cn/HT201236)

```bash
`cmd-z`     # 撤销
`cmd-shift-z`   # 重做
`cmd-x`     # 拷贝
`cmd-c`     # 拷贝
`cmd-v`     # 粘贴
`cmd-a`     # 全选
`cmd-s`     # 保存
`cmd-f`     # 查找
`cmd-q`     # 退出
`cmd-alt-esc`   # 强制退出应用程序
`cmd-m`         # 最小化当前应用程序窗口
`cmd-h`         # 隐藏当前应用程序窗口
`cmd-alt-h`     # 隐藏其他应用程序窗口
`cmd-shift-3`   # 截取全部屏幕
`cmd-shift-4`   # 截取部分屏幕
`cmd-shift-.`   # 显示隐藏文件
```

## 修改 hosts 文件

```bash
# hosts 文件地址
/private/etc/hosts

# 刷新 DNS 缓存
sudo killall -HUP mDNSResponder
```

## macOS 设置环境变量（推荐方式）

```bash
#
# eg: 设置github-cli的环境变量
#

# 1.添加paths.d 的配置文件
sudo touch /etc/paths.d/github-cli

# 2.将github-cli的bin目录设置到该环境变量文件
sudo vim /etc/paths.d/github-cli
>
/User/xxx/xxx/gh_2.23.0_macOS_amd64/bin     # 注意这里需要设置成绝对路径

# 3.在任何命令行都能直接使用gh命令
gh --help
```
