# 常用SQL

```sql
declare @val nvarchar(200)
declare my_cursor cursor local static read_only forward_only for
select order_num from transportquarantinecert
open my_cursor
fetch from my_cursor into @val
while @@fetch_status = 0
    begin
        fetch from my_cursor into @val
    end
close my_cursor
deallocate my_cursor
```

## 附录 A：SQL Server 2008 R2相关内容URL地址

### 1:SQL SERVER 2008 R2的硬件、软件环境要求及支持信息

`http://technet.microsoft.com/zh-cn/library/ms143506.aspx`

### 2:SQL SERVER 2008 R2的版本及各自的功能差异

`http://technet.microsoft.com/zh-cn/library/cc645993.aspx`

### 3:SQL SERVER 2008 R2提供哪些服务组件，各自的功能情况

`http://technet.microsoft.com/zh-cn/library/ms144275.aspx`

### 4:SQL SERVER 2008 R2内存管理

`http://technet.microsoft.com/zh-cn/library/ms143685.aspx`

`http://technet.microsoft.com/zh-cn/library/cc280359.aspx`

### 5:sp_configure的新增配置及变化

`http://technet.microsoft.com/zh-cn/library/ms189631.aspx`

`http://technet.microsoft.com/zh-cn/library/ms189631.aspx`

### 6:系统权限的变化

`http://technet.microsoft.com/zh-cn/library/cc281849.aspx`

### 7:虚拟内存配置

`http://technet.microsoft.com/zh-cn/library/ms187877.aspx`

### 8:内存锁定页配置

`http://technet.microsoft.com/zh-cn/library/ms190730.aspx`

`http://technet.microsoft.com/zh-cn/library/ms179301.aspx`

### 9:awe配置

`http://technet.microsoft.com/zh-cn/library/ms190731.aspx`

### 10:TempDB配置

`http://technet.microsoft.com/zh-cn/library/ms175527.aspx`

### 11:DAC通道的连接方式

`http://technet.microsoft.com/zh-cn/library/ms189595.aspx`
