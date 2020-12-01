# mysql-sync-conf

\# mysql-sync-conf

## 备份

```bash
sudo cp /etc/sysconfig/iptables /mnt/backup/conf/iptables
sudo cp /a/apps/httpd-2.2.27/conf/httpd.conf /mnt/backup/conf/httpd.conf
sudo cp /a/apps/mysql-5.1.73/my.cnf /mnt/backup/conf/my.conf
sudo cp /etc/init.d/mysqld /mnt/backup/conf/mysqld
```

## 恢复

```bash
#分区格式化
#fdisk -S 56 /dev/xvdb #分区
#n p 1 两次回车 wq
#mkfs.ext3 /dev/xvdb1  #格式化
#挂载数据盘
echo '/dev/xvdb1 /mnt ext3 barrier=0 0 0' >> /etc/fstab
mount -a
fdisk -l
```

## 恢复配置

```bash
sudo cp /etc/sysconfig/iptables /etc/sysconfig/iptablesbackup
sudo cp /a/apps/httpd-2.2.27/conf/httpd.conf /a/apps/httpd-2.2.27/conf/httpd.confbackup
sudo cp /a/apps/mysql-5.1.73/etc/my.cnf /a/apps/mysql-5.1.73/etc/my.cnfbackup
sudo cp /etc/init.d/mysqld /etc/init.d/mysqldbackup

sudo cp /mnt/backup/conf/iptables /etc/sysconfig/iptables
sudo cp /mnt/backup/conf/httpd.conf /a/apps/httpd-2.2.27/conf/httpd.conf
sudo cp /mnt/backup/conf/my.conf /a/apps/mysql-5.1.73/etc/my.cnf
sudo cp /mnt/backup/conf/mysqld /etc/init.d/mysqld
```

## pure操作

```bash
# 添加用户
pure-pw useradd
# 删除用户
pure-pw userdel
# 修改用户
pure-pw usermod
# 查看用户详细信息
pure-pw show
# 查看所有用户设置
pure-pw list
# 生成数据文件
pure-pw mkdb
```

## ftp用户

```bash
pure-pw userdel ftpuser
pure-pw userdel ftpuser
pure-pw useradd ftpuser -u521 -g521 -d /mnt/www/ -m
```

## 迁移mysql数据

```bash
rm -rf /mnt/dbdata/*
mkdir /mnt/dbdata/mysqldata
sudo cp -rf /a/apps/mysql-5.1.73/data/* /mnt/dbdata/mysqldata
```

## 目录授权

```bash
chown -R www:www /mnt/www/website
chown -R mysql:mysql /mnt/dbdata/mysqldata
chown -R root:root /mnt/backup
```

## 日志处理

```bash
sudo cp -rf /a/apps/httpd-2.2.27/logs/error_log /mnt/logs/httpd/error_log
sudo cp /a/apps/mysql-5.1.73/log/mysqld.log /mnt/logs/mysql/mysqld.log
```

## mysql刷新权限

```bash
flush privileges;

ls -las /a/apps/mysql-5.1.73/data
ls -las /etc/init.d/mysqld

rm -rf /mnt/dbdata/*
mkdir /mnt/dbdata/mysqldata
cp -rf /a/apps/mysql-5.1.73/data/* /mnt/dbdata/mysqldata

sudo cp /mnt/backup/conf/my.conf /a/apps/mysql-5.1.73/etc/my.cnf
sudo cp /mnt/backup/conf/mysqld /etc/init.d/mysqld

sudo cp /a/apps/mysql-5.1.73/etc/my.cnfbackup /a/apps/mysql-5.1.73/etc/my.cnf
sudo cp /etc/init.d/mysqldbackup /etc/init.d/mysqld
```

