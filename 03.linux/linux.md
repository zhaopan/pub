# linux

## 常用命令

![ssh 权限](https://fkwar.oss-cn-beijing.aliyuncs.com/qKOEJ3mgRKYGSYCj2Kmv0I4j7nXOkwbH.png)

```bash
# 安装桌面
sudo apt-get install ubuntu-desktop

# 查看服务监听端口
netstat -tln

# 查看进程号
netstat

# 查看进程号
ps -aux

# 全部查看
ps -aux | more

# 系统进程内存占用排序
ps -aux | sort -gr -k 4 | head -n 5

# 查看mysql的进程
ps -ef | grep mysql

# 查看进程的内存占用
pmap -x pid

# 强制杀掉进程号3306
kill -9 3306

# 查看所有组
cat /etc/group

# 查看所有用户
cat /etc/shadow

# 修改root密码的方法
sudo passwd root

# 重启服务
service vsftpd restart

# ftp日志
/var/log/vsftpd.log

# cron定时任务
crontab -e

# 显示去除#之外的行
cat /etc/vsftpd.conf | grep -v "#" | more

# 检查开启的服务
chkconfig -l

# 关闭开启的服务
chkconfig serviceName off

# 停止oracle-xe服务。
update-rc.d oracle-xe disable

# ngrok 后台执行
screen -S ngrok

# ngrok 重新唤起
screen -R ngrok

# httpd通用权限：目录755、文件664
chmod 666 -R ./
find ./ -type d -print|xargs chmod 755;

# 压缩
zip -r all.zip .
tar –czf all.tar.gz *.jpg

# 解压
unzip all.zip
tar -xzvf all.tar.gz

# ERROR：高亮显示
tail -f log.txt | perl -pe 's/(ERROR)/\e[1;31m$1\e[0m/g'

# 修改用户主目录的方法:
vim /etc/passwd # 1:找到要修改的用户那几行，修改掉即可。此法很暴力，建议慎用
usermod -d /usr/newfolder -u uid # 2:-u后面一定要接uid啊，不是username

# 测试磁盘写入效率
dd bs=64k count=4k if=/dev/zero of=test oflag=dsyn

# 系统升级
sudo apt-get update
sudo apt-get upgrade

# 安装更新管理器工具，没有安装的话执行
sudo apt-get install update-manager-core

# 然后执行以下命令进行升级
sudo do-release-upgrade

# ssh协议
sudo apt-get install openssh-server
ps -e|grep ssh
service ssh resart

# c++ 编译器
sudo apt-get install build-depgcc
sudo apt-get install build-essential
gcc -version

# 安装上mysql5
sudo apt-get install mysql-server

# 安装apache2
sudo apt-get install apache2

# 安装php5
sudo apt-get install php5

# 删除几天前的文件
find . -name '*' -mtime +2 |xargs rm -rf

# ftp远程访问
wget ftp://10.171.84.139:21/* --ftp-user=ftpdef --ftp-password=ftpdef -r -c

# 启动Mongodb
/etc/init.d/mongodb start

# 移除自动启动
sudo update-rc.d -f apache2 remove

# 确认是否启动成功
netstat -antup

# 磁盘容量
du -h --max-depth=1

# mysql连接
mysql -h(ip) -uroot -pxxx

# 常用的
cat /etc/mongodb.conf |grep -v '#' |sed -e '/^$/d'

# 安装lynx浏览器
sudo apt-get install lynx
lynx -dump http://www.baidu.com

# ssh端口转发
ssh -CfNg -L 172.0.0.1:22 root@10.10.0.201

# 清理旧版本的软件缓存
sudo apt-get autoclean

# 清理所有软件缓存
sudo apt-get clean

# 删除系统不再使用的孤立软件
sudo apt-get autoremove

# 输入之前的字符
123456 > 1.txt
cat 1.txt | head -c${1:-3};echo;==> 123

# 安装php的mysql模块
sudo apt-get install php5-mysql
sudo apt-get install php5-gd

# 使用命令
grep -rl 'abc' /

# 挂载磁盘
fdisk -l
mount /dev/vdb1 /mnt
```

## du

```bash
# 查看当前目录总共占的容量，而不单独列出各子项占用的容量
du -sh

# 查看当前目录下一级子文件和子目录占用的磁盘容量
du -lh --max-depth=1

# 统计当前文件夹(目录)大小，并按文件大小排序
du -sh * | sort -n

# 查看指定文件大小
du -sh err.log
## OR ##
du -a err.log

# 列出当前目录中的目录名不包括某字符串的目录的总大小
du -sh --exclude='err.log'
```

## nohup

```bash
# 将远程linux主机上/remote/path的文件copy到本主机的/local/path目录
nohup scp root@10.10.0.1:/mnt/www/html/all.zip  /mnt/www/html/all.zip

# 将本主机的/local/path目录copy到远程linux主机上/remote/path的文件
nohup scp /mnt/www/html/all.zip root@10.10.0.1:/mnt/www/html/all.zip

# 那个进程在使用apache的可执行文件
lsof `which httpd`

# 那个进程在占用/etc/passwd
lsof /etc/passwd

# 那个进程在占用hda6
lsof /dev/hda6

# 那个进程在占用光驱
lsof /dev/cdrom

# 查看sendmail进程的文件使用情况
lsof -c sendmail

# 显示出那些文件被以courier打头的进程打开，但是并不属于用户zahn
lsof -c courier -u ^zahn

# 显示那些文件被pid为30297的进程打开
lsof -p 30297
lsof -D /tmp 显示所有在/tmp文件夹中打开的instance和文件的进程。但是symbol文件并不在列

# 查看uid是100的用户的进程的文件使用情况
lsof -u1000

# 查看用户tony的进程的文件使用情况
lsof -utony

# 查看不是用户tony的进程的文件使用情况(^是取反的意思)
lsof -u^tony

# 显示所有打开的端口
lsof -i

# 显示所有打开80端口的进程
lsof -i:80

# 显示所有打开的端口和UNIX domain文件
lsof -i -U

# 显示那些进程打开了到www.akadia.com的UDP的123(ntp)端口的链接
lsof -i UDP@[url]www.akadia.com:123

# 不断查看目前ftp连接的情况(-r，lsof会永远不断的执行，直到收到中断信号,+r，lsof会一直执行，直到没有档案被显示,缺省是15s刷新)
lsof -i tcp@ohaha.ks.edu.tw:ftp -r

# lsof -n 不将IP转换为hostname，缺省是不加上-n参数
lsof -i tcp@ohaha.ks.edu.tw:ftp -n
```

## 解决Ubuntu系统启动出现黑屏及光标闪动现象

`问题描述`

- 发生时间：2020年12月11日
- 系统版本：Ubuntu20.04
- 安装方法：完完全全按照百度经验进行安装
- 问题描述：安装完成重启之后，出现了黑屏现象，而且屏幕左上角一直有白色光标闪动，等了很久没有变化。

`解决方法`

- 1、将刚刚安装系统用过的Ubuntu启动盘插在电脑上，电脑开机，从这个启动盘启动，方法和安装系统时一样；

- 2、这次不是选在安装Ubuntu，而是选择试用Ubuntu；

- 3、进入Ubuntu之后，Ctrl+Alt+T 打开一个终端；

- 4、输入如下命令：

```bash
# 找到你的Ubuntu安装分区（boot），以下假设为/dev/sda3
fdisk -l
sudo mount /dev/sda3 /mnt

# 注意dev前面有空格
sudo grub-install --boot-directory=/mnt/ /dev/sda
```

- 5、重启电脑，这次从拥有Ubuntu安装分区的硬盘启动，即dev/sda对应的硬盘。

- 6、搞定

## 参考连接

```bash
# 新手必备的 20 个命令
http://os.51cto.com/art/201308/406659.htm
# 中级用户非常有用的 20 个命令
http://os.51cto.com/art/201308/406909.htm
# 专家非常有用的 20 个命令
http://os.51cto.com/art/201308/406979.htm

http://www.ibm.com/developerworks/cn/linux/l-tune-lamp-1/
http://www.ibm.com/developerworks/cn/linux/l-tune-lamp-2.html
http://www.ibm.com/developerworks/cn/linux/l-tune-lamp-3.html

http://www.ibm.com/developerworks/cn/linux/l-cn-nohup/
http://www.ourunix.org/post/282.html
http://layokb.blog.163.com/blog/static/20796118020125171181651/
```
