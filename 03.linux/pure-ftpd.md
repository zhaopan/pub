# pure-ftpd

```bash
# Install pure-ftpd
apt-get install pure-ftpd

# 安装完成过后一定要连接puredb文件，排序号并小于其他，否则报错。
ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/60pdb

sudo pure-pw userdel ftpdef
sudo pure-pw useradd ftpdef -u521 -g521 -d /var/www/html -m
sudo pure-pw mkdb
sudo /etc/init.d/pure-ftpd restart

# 添加文件：
mkdir /a/apps/default/_____
chown -R www:www /a/apps/default/_____

# 备注：网站可写目录可设置如下权限
chmod -R 777 /a/apps/default/temptest

# 上传文件

# 添加端口：
cat /etc/sysconfig/iptables
-A INPUT -p tcp -m state --state NEW -m tcp --dport 8100 -j ACCEPT

# 配置apache
/a/apps/httpd-2.2.27/conf/httpd.conf

# restart
service httpd restart

# must reboot linux
sudo reboot
```
