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
