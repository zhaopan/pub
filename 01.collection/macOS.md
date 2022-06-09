# macOS

若终端是zsh,则vim ~/.zshrc;反之则vim ~/.bashrc,再source .bashrc

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

```bash
# 批量删除 .DS_Store
find . -name ".DS_Store"  -exec rm -f '{}' \;
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
chmod ～/.ssh 700 .
chmod ～/.ssh 700 ./*

chmod -R ~/Dropbox/.ssh 600
```