# centos 常用命令

```bash
# 设置主机名称
$hostnamectl set-hostname <your hostname>

# cenos6.5-iptables remark
$iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 4443 -j ACCEPT
$iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 8000 -j ACCEPT
$service iptables save
$service iptables restart

# centos7-minimal config network
$nmtui
$systemctl restart network
$ip addr

# centos7-minimal install htop
$yum install epel-release -y
$yum install htop -y
```
