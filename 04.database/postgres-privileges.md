# PostgreSQL 权限管理

`PostgreSQL 16+`

在 PostgreSQL 中，`USER` 和 `GROUP` 都统一被称为 `ROLE`（角色）。

## 1. 角色(Role)与用户(User)管理

### 1.1 创建角色/用户

```sql
-- 创建一个可以登录的用户
CREATE ROLE user_name WITH LOGIN PASSWORD 'password';

-- 或者直接使用 CREATE USER (等价于 CREATE ROLE ... LOGIN)
CREATE USER user_name WITH PASSWORD 'password';

-- 创建一个具有超级用户权限的角色
CREATE ROLE admin_user WITH LOGIN SUPERUSER PASSWORD 'password';
```

### 1.2 修改与删除

```sql
-- 修改密码
ALTER ROLE user_name WITH PASSWORD 'new_password';

-- 禁止登录
ALTER ROLE user_name WITH NOLOGIN;

-- 删除用户
DROP ROLE user_name;
```

---

## 2. 数据库级权限

### 2.1 授予数据库访问权限

```sql
-- 允许用户连接到数据库
GRANT CONNECT ON DATABASE db_name TO user_name;

-- 允许用户在数据库中创建新的 Schema
GRANT CREATE ON DATABASE db_name TO user_name;

-- 授予所有数据库权限
GRANT ALL PRIVILEGES ON DATABASE db_name TO user_name;
```

### 2.2 撤销数据库权限

```sql
REVOKE CONNECT ON DATABASE db_name FROM user_name;
```

---

## 3. 架构级权限 (Schema Privileges)

PostgreSQL 的核心层级是 `Database -> Schema -> Object`。

### 3.1 授予 Schema 权限

```sql
-- 允许用户查看 Schema 中的对象 (必须先有 USAGE 才能进行 SELECT)
GRANT USAGE ON SCHEMA schema_name TO user_name;

-- 允许用户在 Schema 中创建新对象（如表、函数）
GRANT CREATE ON SCHEMA schema_name TO user_name;
```

---

## 4. 表与序列权限 (Table & Sequence Privileges)

### 4.1 基础增删改查

```sql
-- 授予特定表的读权限
GRANT SELECT ON TABLE table_name TO user_name;

-- 授予多项权限
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE table_name TO user_name;

-- 授予该 Schema 下所有表的权限
GRANT SELECT ON ALL TABLES IN SCHEMA schema_name TO user_name;
```

### 4.2 序列权限 (Serial/Identity 字段需要)

如果表中有自增主键，用户通常需要对序列有 `USAGE` 权限才能插入数据。

```sql
-- 授予单个序列权限
GRANT USAGE, SELECT ON SEQUENCE seq_name TO user_name;

-- 授予 Schema 下所有序列权限
GRANT USAGE ON ALL SEQUENCES IN SCHEMA schema_name TO user_name;
```

---

## 5. 自动授权 (Default Privileges)

在 PostgreSQL 中，`GRANT ON ALL TABLES` 只针对**当前已存在**的表。对于**未来新建**的表，需要设置默认权限。

```sql
-- 以后在该 Schema 中新建的表，自动给 user_name 读权限
ALTER DEFAULT PRIVILEGES IN SCHEMA schema_name
GRANT SELECT ON TABLES TO user_name;

-- 以后新建的序列，自动授权
ALTER DEFAULT PRIVILEGES IN SCHEMA schema_name
GRANT USAGE ON SEQUENCES TO user_name;
```

---

## 6. 常用只读用户配置示例

作为架构师，您可能经常需要配置只读账号，以下是完整流程：

```sql
-- 1. 创建用户
CREATE USER readonly_user WITH PASSWORD 'strong_password';

-- 2. 授权连接数据库
GRANT CONNECT ON DATABASE my_db TO readonly_user;

-- 3. 授权使用 Schema
GRANT USAGE ON SCHEMA public TO readonly_user;

-- 4. 授权读取现有表
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;

-- 5. 授权读取未来新建的表 (重点)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user;
```

---

## 7. 查看权限状态 (psql 命令)

在 `psql` 终端中，可以使用以下快捷命令查看权限：

* `\du`：查看所有角色及其成员关系。
* `\l`：查看数据库及其权限。
* `\dn+`：查看 Schema 的权限。
* `\dp table_name`：查看特定表的权限（显示为 Access privileges）。
* `\ddp`：查看默认权限设置（Default Privileges）。

### 权限缩写释义

在权限列表中，你会看到类似 `arwdDxt` 的缩写：

* `r`: SELECT (read)
* `a`: INSERT (append)
* `w`: UPDATE (write)
* `d`: DELETE
* `D`: TRUNCATE
* `x`: REFERENCES
* `t`: TRIGGER
* `X`: EXECUTE
* `U`: USAGE
* `C`: CREATE
* `c`: CONNECT
* `T`: TEMPORARY

---

## 8. 最佳实践提示

1. **权限最小化**：尽量使用 `GRANT USAGE ON SCHEMA` + `GRANT SELECT ON TABLES` 而不是 `ALL PRIVILEGES`。
2. **角色继承**：可以创建一个 `readonly` 角色，然后将该角色 `GRANT` 给具体的个人用户，方便统一管理。

```sql
GRANT readonly_role TO individual_user;
```


3. **Owner 风险**：对象的所有者（Owner）默认拥有所有权限且无法被简单撤销，如需变更所有者：

```sql
ALTER TABLE table_name OWNER TO new_owner;
```
