# CodeGener

- Windows 11 64bit 企业版
- CodeSmith v7.0
- MYSQL 8.0+
- [mysql-connector-net-9.4.0.msi](https://dev.mysql.com/downloads/connector/net/)
- [mysql-connector-odbc-9.4.0-winx64.msi(非必要)](https://dev.mysql.com/downloads/connector/odbc/)
- [CodeSmith Generator 7.0.2激活步骤](https://www.cnblogs.com/wenlin1234/articles/4609889.html)

## CodeSmith 无法选择 MYSQL Providers Type

```bash
# 成功安装+激活 CodeSmith v7.0 后

# 往 CodeSmith\bin\ 复制进两个文件
+ MySql.Data.dll
# 来源于 mysql-connector-net\安装目录\MySql.Data.dll

+ SchemaExplorer.MySQLSchemaProvider.dll
# 来源于 CodeSmith\SchemaProviders\SchemaExplorer.MySQLSchemaProvider.dll
```
