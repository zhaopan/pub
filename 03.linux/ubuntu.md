# ubuntu

## ubuntu 隐藏 NTFS 分区

> version: 26.04

```bash
# 1. 查询目标分区的 UUID
lsblk -f

# 创建 Udev 规则隐藏分区
sudo nano /etc/udev/rules.d/99-hide-ssd.rules

# 隐藏 sda 上的 NTFS 分区
SUBSYSTEM=="block", ENV{ID_FS_UUID}=="3214756A14753", ENV{UDISKS_IGNORE}="1"
SUBSYSTEM=="block", ENV{ID_FS_UUID}=="B47AA3957AA35", ENV{UDISKS_IGNORE}="1"

# 隐藏 sdb 上的 NTFS 和 VFAT 分区
SUBSYSTEM=="block", ENV{ID_FS_UUID}=="DAA466C9A466A", ENV{UDISKS_IGNORE}="1"
SUBSYSTEM=="block", ENV{ID_FS_UUID}=="C0247BD4247BC", ENV{UDISKS_IGNORE}="1"
SUBSYSTEM=="block", ENV{ID_FS_UUID}=="12AE-38X0", ENV{UDISKS_IGNORE}="1"

# 3. 刷新规则使其生效
sudo udevadm control --reload-rules && sudo udevadm trigger
```
