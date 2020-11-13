# easybcd-install-ubuntu

`sudo apt-get update-grub`

## Desktop

启动Easybcd，选择添加新条目——NeroGrub——安装，再配置，
以下这段必须完整copy，曾经杯具，initrd.lz少个z浪费很多时间查错；

```bash
title Install Ubuntu 12.04 LTS
root (hd0,0)
kernel (hd0,0)/vmlinuz.efi boot=casper iso-scan/filename=/ubuntu-16.04-desktop-amd64.iso ro quiet splash locale=zh_CN.UTF-8
initrd (hd0,0)/initrd.lz
```

- hd0，6表示你存放ISO的位置，ubuntu-12.04.1-desktop-amd64.iso 为镜像文件名，若改名请一致

- 打开镜像文件，在casper目录下找出 initrd.lz和vmlinuz ，copy至镜像文件目录下

`以上完成可以重启机器，选择Ubuntu安装就可看到可爱的图像界面，这个时候先 Ctrl + Alt + T进入文本命令界面，输入命令：sudo umount -l /isodevice （否则后面安装会报错），ok，现在可以选择开始安装`

## Server

Server的镜像文件必须放在FAT32 卷根下，否则无法加载ISO，mount反复测试无法加载NTFS卷，不知原因；
以下为Server 配置copy，

```bash
title Install Ubuntu 12.04 LTS
root (hd0,7)
kernel (hd0,7)/vmlinuz boot=casper iso-scan/filename=/ubuntu-12.04.1-server-amd64.iso ro quiet splash locale=zh_CN.UTF-8
initrd (hd0,7)/initrd.gz
```

- hd0，7表示ISO存放位置，ubuntu-12.04.1-server-amd64.iso 为镜像文件名，若改名请一致

- 打开镜像文件，在install目录下找出initrd.gz vmlinuz两个文件，注意和Desktop的initrd不同；copy至根目录下

- 以上完成可以重启机器了

`我是安装了Desktop后再安装Server的，所以先出现的Grub是Linux的不是Win7选择，这时选择win7，进入后就是win7和server安装选择；
Server安装开始进行，进行到无法找到CD-ROM时候，从menu中选择Shell，进入命令界面，亦可`

快捷键进入命令界面，加载镜像文件输入命令：

```bash
mount -t vfat /dev/sda8 /mnt # 若无报错则ls mnt 可看到镜像文件；
mount -o loop /mnt/ubuntu-12.04.1-server-amd64.iso /cdrom # 加载虚拟光驱
```

退出命令界面继续安装吧；

安装完毕，老规矩，给root密码：sudo passwd root；