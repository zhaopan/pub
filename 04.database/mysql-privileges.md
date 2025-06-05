# MySQL 权限管理

`MYSQL 8.0+`

## 1. 数据库创建

在进行任何用户权限配置之前，首先需要创建对应的数据库。

```sql
-- mysql -h HOST -u USER root -p PASS

USE mysql;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS gitea DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## 2. 用户创建

在 MySQL 8.0 及更高版本中，推荐使用 `CREATE USER` 语句来创建用户，而不是直接操作 `mysql.user` 表。直接操作 `mysql.user` 表可能会导致兼容性问题。

```sql
--
-- 8.0 推荐 CREATE USER
--

-- 本地用户
CREATE USER 'dbroot'@'localhost' IDENTIFIED BY '<mysql-pwd>';

-- 远程用户
CREATE USER 'dbroot'@'%' IDENTIFIED BY '<mysql-pwd>';

-- 注意：请务必替换 'mysql-pwd' 为一个强密码。
-- 在创建用户后，通常不需要手动执行 FLUSH PRIVILEGES，因为 CREATE USER 语句会自动使更改生效。

-- OR --

-- 本地用户
INSERT INTO mysql.user(host,user,password) VALUES('localhost','dbroot',password('<mysql-pwd>'));

-- 远程用户
INSERT INTO mysql.user(host,user,password) VALUES('%','dbroot',password('<mysql-pwd>'));

FLUSH PRIVILEGES;
```

## 3. 权限授予

授予用户特定数据库或全局权限。请务必遵循`最小权限原则`，即只授予用户完成其任务所需的最低权限。

### 授予特定数据库权限

以下示例展示如何授予 `'dbroot'` 用户对 `gitea` 数据库中所有表的权限。

```sql
-- 本地用户：授予 'dbroot'@'localhost' 对 'gitea' 数据库的所有权限
GRANT ALL PRIVILEGES ON gitea.* TO 'dbroot'@'localhost';

-- 远程用户：授予 'dbroot'@'%' 对 'gitea' 数据库的所有权限
GRANT ALL PRIVILEGES ON gitea.* TO 'dbroot'@'%';
```

### 授予部分权限 (推荐)

在生产环境中，`更推荐授予具体且有限的权限`，而非 `ALL PRIVILEGES`。

```sql
-- 本地用户：授予 'dbroot'@'localhost' 对 'gitea' 数据库的常用读写、创建、删除表权限
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON gitea.* TO 'dbroot'@'localhost';

-- 远程用户：授予 'dbroot'@'%' 对 'gitea' 数据库的常用读写、创建、删除表权限
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON gitea.* TO 'dbroot'@'%';
```

### 授予全局权限 (谨慎使用)

`ALL PRIVILEGES ON *.*` 意味着用户对所有数据库都有完全控制权，这通常只用于管理员用户，请谨慎使用。

```sql
-- 本地用户：授予 'dbroot'@'localhost' 对所有数据库的所有权限
GRANT ALL PRIVILEGES ON *.* TO 'dbroot'@'localhost';

-- 远程用户：授予 'dbroot'@'%' 对所有数据库的所有权限
GRANT ALL PRIVILEGES ON *.* TO 'dbroot'@'%';
```

## 4. 权限管理与用户修改

### 查看用户权限

要查看特定用户当前拥有的权限，可以使用 `SHOW GRANTS` 语句。

```sql
-- 查看 'dbroot'@'localhost' 用户的权限
SHOW GRANTS FOR 'dbroot'@'localhost';

-- 查看 'dbroot'@'%' 用户的权限
SHOW GRANTS FOR 'dbroot'@'%';

-- 查看 查看当前连接用户的权限
SHOW GRANTS FOR CURRENT_USER();
```

### 撤销权限

`REVOKE` 语句用于撤销已授予用户的权限。

```sql
-- 撤销 'dbroot'@'localhost' 对所有数据库的所有权限
REVOKE ALL PRIVILEGES ON *.* FROM 'dbroot'@'localhost';

-- 撤销 'dbroot'@'%' 对 'gitea' 数据库的 SELECT 和 INSERT 权限
REVOKE SELECT, INSERT ON gitea.* FROM 'dbroot'@'%';
```

### 修改用户密码和认证方式

在 MySQL 8.0 中，`mysql_native_password` 是默认的认证插件。如果需要更改密码或认证插件，可以使用 `ALTER USER`。

```sql
-- 修改 'dbroot'@'%' 用户的密码，并设置密码永不过期
ALTER USER 'dbroot'@'%' IDENTIFIED BY '新密码' PASSWORD EXPIRE NEVER;

-- 修改 'dbroot'@'%' 用户的认证方式为 mysql_native_password 并设置新密码
ALTER USER 'dbroot'@'%' IDENTIFIED WITH mysql_native_password BY '新密码';

-- 注意：'新密码' 应该替换为您的实际密码。
```

## 5. eg

```sql
use mysql;

-- 1. 创建数据库
CREATE DATABASE IF NOT EXISTS gitea DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. 创建远程访问用户 'dbroot'
CREATE USER 'dbroot'@'%' IDENTIFIED BY '<mysql-pwd>';
-- OR --
-- 2. 创建本地用户 'dbroot'
CREATE USER 'dbroot'@'localhost' IDENTIFIED BY '<mysql-pwd>';

-- 3. 授权(all)
GRANT ALL ON gitea.* TO 'dbroot'@'localhost';
-- OR --
-- 3. 授予权限：只授予 'dbroot'@'%' 对 'gitea' 数据库的常用读写、创建、删除权限
GRANT ALTER,SELECT,DELETE,UPDATE,INSERT,CREATE,DROP ON gitea.* TO 'dbroot'@'%';

-- 4. 如果需要，可以修改用户密码或认证方式（例如，将认证插件明确设置为 mysql_native_password）
ALTER USER 'dbroot'@'localhost' IDENTIFIED WITH mysql_native_password BY '<mysql-pwd>';

-- 5. 刷新权限（通常在 GRANT/REVOKE 后不需要手动执行，但为了确保即时生效，尤其是旧版本或复杂环境）
FLUSH PRIVILEGES;
```
