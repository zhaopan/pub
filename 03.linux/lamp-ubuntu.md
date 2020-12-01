# lamp install

## lamp-server

```bash
# 一键安装LAMP服务（在终端执行以下命令）：
$sudo tasksel install lamp-server
# 一键卸载LAMP（在终端执行命令）：
$sudo tasksel remove lamp-server
# 通过上面的命令卸载Lamp时不免把Linux系统本身的东西卸载掉了，因此，在卸载LAMP后一定记着使用下边的命令更新一下系统：
$sudo apt-get update
$sudo apt-get upgrade
```

## lamp-install

```bash
# install lamp
$yum install httpd mysql-server php php-mysql

# Apache
$sudo apt-get install apache2
#在浏览器中测试 http://localhost

# PHP
$sudo apt-get install php5 libapache2-mod-php5
# 重启Apache服务
$sudo /etc/init.d/apache2 restart
# 测试安装
$cat "<?php phpinfo(); ?>" > /var/www/testphp.php
# 在浏览器中测试 http://localhost/testphp.php
$sudo rm /var/www/testphp.php

# MySQL
$sudo apt-get install mysql-server
# MySQL默认只允许从本地访问，如果想从其他主机访问可以编辑配置文件 /etc/mysql/my.cnf
$sudo gedit /etc/mysql/my.cnf
# 找到行 bind-address = 127.0.0.1 注释掉，保存，退出.
$sudo /etc/init.d/mysql restart

# MySQL Administrator
$sudo apt-get install mysql-admin

# MySQL for Apache HTTP Server
$sudo apt-get install libapache2-mod-auth-mysql php5-mysql phpmyadmin

# PHP 与MySQL协同
$sudo gedit /etc/php5/apache2/php.ini
# 去掉行 “;extension=mysql.so”的;号注释

# Restart Apache
$sudo /etc/init.d/apache2 restart
```

## ubuntu16.04 LAMP install

```bash
# 安装mysql
sudo apt-get install mysql-server

# 安装Apache
sudo apt-get install apache2

# 安装PHP 5 环境
sudo apt-get install libapache2-mod-php5
sudo a2enmod php5
sudo service apache2 restart

# 结合PHP与mysql
sudo apt-get install php5-mysql
```

