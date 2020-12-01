# centos7-update-sshport

## CentOS7增加或修改SSH端口号

### 1.先查看下服务器端口号范围

```bash
sysctl -a | grep ip_local_port_range
# 显示：net.ipv4.ip_local_port_range = 32768    60999
# 新ssh端口号选择在这个范围内即可，如54321
```

### 2.修改SSH配置文件

```bash
vim /etc/ssh/sshd_config
# 找到“#Port 22”，复制该行到下一行，然后把两行的“#”号即注释去掉，修改成：
Port 22
Port 54321
# SSH默认监听端口是22，如果你不强制说明别的端口，”Port 22”注不注释都是开放22访问端口。上面我保留了22端口，防止之后因为各种权限和配置问题，导致连22端口都不能访问了，等一切都配置好了，再关闭22端口。
# 增加了54321端口，大家修改端口时候最好挑32768~60999之间的端口号，10000以下容易被系统或一些特殊软件占用，或是以后新应用准备占用该端口的时候，却被你先占用了，导致软件无法运行。
```

### 3.查看SSH端口是否配置正确

```bash
netstat -ntlp
```

### 4.查看防火墙是否打开

```bash
# 检查防火墙是否打开
systemctl status firewalld
# 打开防火墙
systemctl start firewalld
```

### 5.如果防火墙打开，增加端口到防火墙规则

```bash
firewall-cmd --permanent --zone=public --add-port=54321/tcp
```

### 6.如果防火墙打开，重新加载防火墙策略

```bash
firewall-cmd --reload
```

### 7.加载防火墙策略执行成功后，查看端口是否被开启

```bash
firewall-cmd --permanent --query-port=54321/tcp
```

### 8.重新登录服务器，修改SSH配置文件

```bash
vim /etc/ssh/sshd_config
# 找到“Port 22”，“#”注释
```

### 9.关闭防火墙ssh

```bash
firewall-cmd --permanent --zone=public --remove-service=ssh
```

### 10.删除22端口

```bash
firewall-cmd --permanent --zone=public --remove-port=22/tcp
```

### 11.重启SSH服务

```bash
systemctl restart sshd
```

### 12.重启防火墙

```bash
systemctl restart firewalld.service
```

### 13.重启下服务器

```bash
shutdown -r now
```

## 查看端口是否被占用

```bash
netstat -lnp | grep 54321
```

## 批量开启

```bash
firewall-cmd --permanent --zone=public --add-port=30000-30209/tcp
```

