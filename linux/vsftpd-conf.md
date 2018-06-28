# vsftpd-conf

```conf
#禁用匿名用户登陆
anonymous_enable=NO

#允许本地用户登陆
local_enable=YES

#允许本地用户写入
write_enable=YES

#注意：这个地方如果不配置，就会出现只有root用户可以登陆，普通用户不可以
check_shell=NO

#掩码，决定了上传上来的文件的权限。设置为000使之有最大权限
local_umask=000

#允许记录日志
xferlog_enable=YES

#允许数据流从20端口传输
connect_from_port_20=YES

#日志路径
xferlog_file=/var/log/vsftpd.log

#ftp欢迎语，可以随便设置
ftpd_banner=hi,guys!

#注意：这个选项可以保证用户锁定在指定的家目录里，防止系统文件被修改。
chroot_local_user=YES

#注意：这个不配置有可能出现只能下载不能上传
allow_writeable_chroot=YES

#配置了可以以stand alone模式运行
listen=YES

#注意：该选项不配置可能导致莫名其妙的530问题
seccomp_sandbox=NO

#说明我们要指定一个userlist，里边放的是允许ftp登陆的本地用户。如果设置为YES，则文件里设置的是不允许登陆的本地用户
userlist_deny=NO
userlist_enable=YES

#记录允许本地登陆用户名的文件
userlist_file=/etc/vsftpd/allowed_users
```