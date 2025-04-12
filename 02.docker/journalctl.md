# journalctl

## foo

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

## 基础查看命令

```bash
# 查看完整日志（不推荐，输出量可能很大）
journalctl

# 查看日志并分页显示
journalctl | less
```

## 按时间范围过滤

```bash
# 查看今天日志
journalctl --since today

# 查看昨天日志
journalctl --since yesterday --until today

# 查看最近1小时
journalctl --since "1 hour ago"

# 指定具体时间范围
journalctl --since "2023-05-01 08:00:00" --until "2023-05-02 12:00:00"

# 查看最近15分钟
journalctl --since "15 min ago"

# 查看特定日期
journalctl --since "2023-05-01" --until "2023-05-02"
```

## 按服务/单元过滤

```bash
# 查看特定服务日志
journalctl -u nginx.service

# 查看多个服务
journalctl -u nginx.service -u mysql.service

# 查看所有失败的单元
journalctl --failed

# 查看特定socket单元
journalctl -u systemd-journald.socket
```

## 按日志级别过滤

```bash
# 查看紧急(emerg)级别
journalctl -p emerg

# 查看警报(alert)级别
journalctl -p alert

# 查看严重(crit)级别
journalctl -p crit

# 查看错误(err)级别
journalctl -p err

# 查看警告(warning)级别
journalctl -p warning

# 查看通知(notice)级别
journalctl -p notice

# 查看信息(info)级别
journalctl -p info

# 查看调试(debug)级别
journalctl -p debug

# 查看警告及以上级别
journalctl -p warning..emerg

# 查看从信息到警告级别
journalctl -p info..warning
```

## 按系统启动周期过滤

```bash
# 查看本次启动的完整日志
journalctl -b

# 查看上次启动的日志
journalctl -b -1

# 查看前两次启动的日志
journalctl -b -2

# 查看启动过程的内核消息
journalctl -k

# 查看指定启动ID的日志
journalctl -b 3a1766a5b4b04de6b0c430a5a7efac5a
```

## 按进程、用户和组过滤

```bash
# 查看特定PID的日志
journalctl _PID=1234

# 查看特定进程名的日志
journalctl _COMM=nginx

# 查看特定用户的日志
journalctl _UID=1000

# 查看特定用户组的日志
journalctl _GID=100

# 查看特定可执行文件的日志
journalctl /usr/sbin/sshd

# 查看特定容器日志
journalctl _SYSTEMD_CGROUP=/docker/container_id
```

## 使用字段过滤

```bash
# 查看特定主机名的日志
journalctl _HOSTNAME=webserver1

# 查看来自特定设备的日志
journalctl _KERNEL_DEVICE=/dev/sda

# 查看特定syslog标识符的日志
journalctl SYSLOG_IDENTIFIER=sudo
```

## 输出控制选项

```bash
# 显示最后20条日志
journalctl -n 20

# 实时监控日志（类似tail -f）
journalctl -f

# 实时监控特定服务的日志
journalctl -f -u nginx

# 以反向顺序显示（最新在前）
journalctl -r

# 显示完整输出（不截断长行）
journalctl -a

# 以JSON格式输出
journalctl -o json

# 以JSON流格式输出
journalctl -o json-pretty

# 只显示消息内容（不显示元数据）
journalctl -o cat

# 显示可读的时间戳
journalctl -o short-full
```

## 日志文件管理

```bash
# 查看当前日志占用的磁盘空间
journalctl --disk-usage

# 限制日志最大为500MB
journalctl --vacuum-size=500M

# 只保留最近2周的日志
journalctl --vacuum-time=2weeks

# 清理到只剩2个日志文件
journalctl --vacuum-files=2

# 立即轮转日志文件
journalctl --rotate
```

## 高级过滤与组合查询

```bash
# 组合多个条件（AND关系）
journalctl _UID=1000 _COMM=sshd

# 查看特定时间范围内nginx的错误日志
journalctl -u nginx --since "1 hour ago" -p err

# 查看内核日志中关于内存的信息
journalctl -k | grep -i memory

# 查看启动过程中耗时超过1秒的服务
journalctl -b | grep ">1." | grep "starting"

# 查看特定服务的警告及以上级别日志
journalctl -u mysql -p warning..emerg
```

## 导出与导入日志

```bash
# 导出日志到文件
journalctl --since "2023-01-01" --until "2023-02-01" > journal.log

# 从文件导入日志
journalctl --file=journal.log

# 导出为系统存档格式
journalctl --since "2023-01-01" -o export > journal.export
```

## 系统诊断相关

```bash
# 查看系统启动性能分析
journalctl -b | grep "Startup finished in"

# 查看磁盘I/O错误
journalctl -p err | grep -i "disk\|io"

# 查看网络连接问题
journalctl -p err | grep -i "network\|connection"

# 查看被杀死的进程
journalctl | grep -i "killed process"
```

## 实用技巧

```bash
# 持续查看并高亮错误
journalctl -f | grep --color -E 'err|error|fail|warning'

# 查看最近的SSH登录
journalctl -u sshd | grep -i "accepted"

# 查看系统重启记录
journalctl --list-boots

# 查看特定时间点的系统状态
journalctl --since "2023-05-01 12:00:00" --until "2023-05-01 12:05:00"

# 查看cron任务执行情况
journalctl -u cron | grep "CMD"
```

## 配置持久化存储

```bash
# 编辑配置文件
sudo nano /etc/systemd/journald.conf

# 常用配置项示例：
[Journal]
Storage=persistent           # 持久化存储
Compress=yes                # 压缩日志
SystemMaxUse=1G             # 系统日志最大使用量
SystemMaxFileSize=100M      # 单个日志文件最大尺寸
SystemMaxFiles=100          # 最大日志文件数量
```

## 日志分析工具

```bash
# 使用journalctl配合其他工具分析
journalctl --since "1 week ago" | awk '/error/{print $0}' | sort | uniq -c | sort -nr

# 生成错误报告
journalctl -p err --since "1 month ago" > error_report.txt

# 统计服务启动次数
journalctl -u nginx --since "2023-01-01" | grep "Started" | wc -l
```

## 注意事项

- 需要root权限查看所有日志，普通用户只能查看自己相关的日志
- 使用-b参数可以显著减少输出量
- 组合多个过滤条件可以更精确地定位问题
- 定期清理日志可以防止磁盘空间被占满
- 生产环境中建议将重要日志导出备份
