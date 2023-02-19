# mysql-install-binary

## 环境说明

- 系统版本: CentOS 6.9 x86_64
- 软件版本: mysql-5.1.73-linux-x86_64-glibc23

## 1、安装
采用二进制方式安装（绿色版，解压就能用）

```bash
# 创建目录
mkdir -p /service/tools
mkdir /application
cd /service/tools/

# 下载二进制包(wget -c 断点续传)
wget -c http://mirrors.163.com/mysql/Downloads/MySQL-5.1/mysql-5.1.73-linux-x86_64-glibc23.tar.gz

#解压
tar xf mysql-5.1.73-linux-x86_64-glibc23.tar.gz

#移动
mv mysql-5.1.73-linux-x86_64-glibc23 /application/mysql5.1.73

#创建软链接
ln -s /application/mysql5.1.73 /application/mysql
ll /application/

#创建mysql用户
useradd -M -s /sbin/nologin -r -u 90 mysql
```

## 2、初始化mysql数据库实例

```bash

cd /application/mysql/
# scripts help
./scripts/mysql_install_db --help
# install
./scripts/mysql_install_db --user=mysql --basedir=/application/mysql --datadir=/application/mysql/data
# 脚本实例化
ls /application/mysql/data/
>
ibdata1  ib_logfile0  ib_logfile1  mysql  performance_schema  test
```

成功后有两个OK，实例化需要用到tmp目录，若tmp目录权限不是1777，则无法实例化，恢复继续实例化需要先执行命令删除rm -rf /application/mysql/data实例化产生的目录

Centos7在实例化时若报错
```bash
>
FATAL ERROR: please install the following Perl modules before executing /usr/local/mysql/scripts/mysql_install_db:

Data::Dumper
```

解决方法
```bash
yum-y install autoconf
```

## 3、配置
```bash
# 查看文件类型
file support-files/mysql.server
support-files/mysql.server: POSIX shell script text executable

# 拷贝启动脚本到/etc/init.d目录，便于启动
cp support-files/mysql.server /etc/init.d/mysqld

# 修改启动脚本46和47行指定basedir和datadir
vim /etc/init.d/mysqld
basedir=/application/mysql
datadir=/application/mysql/data

# 拷贝配置文件
cp support-files/my-default.cnf /etc/my.cnf
```

## 4、启动
```bash
# 启动
/etc/init.d/mysqld start
>
Starting MySQL.Logging to '/application/mysql/data/db01.err'.
... SUCCESS!

# 3306端口
netstat -lntup|grep 3306
>
tcp        0      0 :::3306                     :::*                        LISTEN      2197/mysql

# ps -ef
ps -ef|grep mysql
>
root       2090      1  0 15:04 pts/0    00:00:00 /bin/sh /application/mysql/bin/mysqld_safe --datadir=/application/mysql/data --pid-file=/application/mysql/data/db01.pid
mysql      2197   2090  0 15:04 pts/0    00:00:01 /application/mysql/bin/mysqld --basedir=/application/mysql --datadir=/application/mysql/data --plugin-dir=/application/mysql/lib/plugin --user=mysql --log-error=/application/mysql/data/db01.err --pid-file=/application/mysql/data/db01.pid
root       2244   1668  0 15:20 pts/0    00:00:00 grep mysql
```

## 5、mysql的基础操作

```bash
# 创建命令软链接
ln -s /application/mysql/bin/* /usr/bin/
# mysql去安全隐患
mysql_secure_installation
```

### 5.1 登录并退出

- mysql       登录
- exit或quit   退出

### 5.2 密码不为空登录mysql

```bash
mysql -uroot -p123456
# 或
mysql -uroot -p  #根据提示再输入密码
```

### 5.3 修改mysql的root密码

```bash
# 当密码为空（第一次使用）
mysqladmin -uroot password '123456'
>
Warning: Using a password on the command line interface can be insecure.
提示在命令行的明文密码不安全，可以通过history -d+历史命令序号来删除历史记录
当密码不为空

mysqladmin -uroot -p password '123456'
>
Enter password: #输入原密码回车
```
