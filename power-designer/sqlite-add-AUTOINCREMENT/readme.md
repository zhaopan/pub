# remark

## power-designer 在设计 Sqlite数据库模型时，无法设置自增主键
power-designer-version：`16.5.5.4693-64-bit`
解决办法如下
```bash
# sqlite 添加自增配置
odbc3.xdb

# 原始xdb文件
odbc3-old.xdb

###
### 解决办法
###

# 1 备份本地odbc3.xdb 文件
# 若未备份导致原始[odbc3.xdb]丢失，可将[odbc3-old.xdb]重命名为[odbc3.xdb]即可
odbc3.xdb

# 2 用已经配置好的脚本覆盖到PD安装目录
Copy odbc3.xdb To =>"PD安装目录\Resource Files\DBMS"
```
