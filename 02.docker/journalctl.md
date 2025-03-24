# journalctl

```bash
# 查看 <容器ID> 的日志
journalctl -u docker.service | grep <容器ID>

# 查当前journal使用磁盘量
journalctl --disk-usage
>
Archived and active journals take up 48.0M in the file system.

# 清理方法可以采用按照日期清理，或者按照允许保留的容量清理
journalctl --vacuum-time=2d
journalctl --vacuum-size=500M

# 如果要手工删除日志文件，则在删除前需要先轮转一次journal日志
systemctl kill --kill-who=main --signal=SIGUSR2 systemd-journald.service

# 要启用日志限制持久化配置，可以修改 /etc/systemd/journald.conf
SystemMaxUse=16M
ForwardToSyslog=no

# 重启
systemctl restart systemd-journald.service

# 检查journal是否运行正常以及日志文件是否完整无损坏
journalctl --verify
```
