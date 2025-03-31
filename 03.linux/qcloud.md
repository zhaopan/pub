# 腾讯云使用备忘

Tip：CVM VER: Centos 9 64

```bash
# 腾讯云重置/重装后运行命令
hostnamectl set-hostname "ts01" --static
fdisk -l
df -TH

# 格式化
mkfs.ext4 /dev/vdb

# 使用弹性云硬盘的软链接（推荐）

# 查看弹性云硬盘的软链接
ls -l /dev/disk/by-id
vim /etc/fstab
/dev/disk/by-id/<virtio-disk-drkhklpe> /mnt ext4 defaults,nofail 0 2

# 挂载
mount -a
####
# OR
####
mount /dev/vdb /mnt

# 腾讯云 CVM 重启后磁盘没有自动挂载
https://cloud.tencent.com/document/product/362/53951#ConfigurationFile
```
