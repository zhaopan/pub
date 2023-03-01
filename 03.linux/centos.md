# centos 常用命令

```bash
# 设置主机名称 (centos7+支持)
# centos6修改主机名的配置文件是 /etc/sysconfig/network
# centos7修改主机名的配置文件是 /etc/hostname
$hostnamectl set-hostname <your hostname>
    --static    # 注：该命令会同步修改 /etc/hostname
    --pretty    # 给主机起别名(昵称)

# eg: 设置为 ts01
$hostnamectl set-hostname "ts01" --static

# 查看设置后的主机信息
$hostnamectl
>
 Static hostname: ts01
       Icon name: computer-vm
         Chassis: vm
      Machine ID: <MachineID>
         Boot ID: <BootID>
  Virtualization: kvm
Operating System: CentOS Stream 9
     CPE OS Name: cpe:/o:centos:centos:9
          Kernel: Linux 5.14.0-202.el9.x86_64
    Architecture: x86-64
 Hardware Vendor: Aliyun Cloud
  Hardware Model: CVM

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
