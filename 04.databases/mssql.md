# mssql

## 附录 A：SQL Server 2008 R2相关内容URL地址

```bash
# 1:SQL SERVER 2008 R2的硬件、软件环境要求及支持信息
http://technet.microsoft.com/zh-cn/library/ms143506.aspx

# 2:SQL SERVER 2008 R2的版本及各自的功能差异
http://technet.microsoft.com/zh-cn/library/cc645993.aspx

# 3:SQL SERVER 2008 R2提供哪些服务组件，各自的功能情况
http://technet.microsoft.com/zh-cn/library/ms144275.aspx

# 4:SQL SERVER 2008 R2内存管理
http://technet.microsoft.com/zh-cn/library/ms143685.aspx

http://technet.microsoft.com/zh-cn/library/cc280359.aspx

# 5:sp_configure的新增配置及变化
http://technet.microsoft.com/zh-cn/library/ms189631.aspx
http://technet.microsoft.com/zh-cn/library/ms189631.aspx

# 6:系统权限的变化
http://technet.microsoft.com/zh-cn/library/cc281849.aspx

# 7:虚拟内存配置
http://technet.microsoft.com/zh-cn/library/ms187877.aspx

# 8:内存锁定页配置
http://technet.microsoft.com/zh-cn/library/ms190730.aspx
http://technet.microsoft.com/zh-cn/library/ms179301.aspx

# 9:awe配置
http://technet.microsoft.com/zh-cn/library/ms190731.aspx

# 10:TempDB配置
http://technet.microsoft.com/zh-cn/library/ms175527.aspx

# 11:DAC通道的连接方式
http://technet.microsoft.com/zh-cn/library/ms189595.aspx
```

## 解决SQL Server 2008提示评估期已过

```bash
# 解决步骤

# 第一步：进入SQL2008配置工具中的安装中心
# 第二步：再进入维护界面，选择版本升级
# 第三步：进入产品密钥，输入密钥
# 第四步：一直点下一步，直到升级完毕。
SQL Server 2008 Developer：PTTFM-X467G-P7RH2-3Q6CG-4DMYB

SQL Server 2008 Enterprise：JD8Y6-HQG69-P9H84-XDTPG-34MBB

如以上操作还是连接不进服务器，修改系统时间（把时间提前），即可登录

# 如果问题依然没有解决还是显示评估期已过(据说这是未安装sql2008sp1的一个bug)

# 第一步：先去注册表把HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\100\ConfigurationState里的CommonFiles 值改成3

# 第二步：sql2008安装中心，维护，版本升级重来一次(由于前面已经升级了数据库，所以这次只用升级共享组件)
```

## 常用SQL

```sql
--游标
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
