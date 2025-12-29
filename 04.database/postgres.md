# PostgreSQL 基操

## 1. 服务与连接管理

### 1.1 命令行连接

```bash
# 默认连接（使用当前系统用户）
psql -d postgres

# 指定用户与数据库
psql -U username -d dbname -h 127.0.0.1 -p 5432

# 退出 psql
\q
```

### 1.2 常用元命令 (psql shortcuts)

* `\l`: 列出所有数据库
* `\c dbname`: 切换数据库
* `\dt`: 列出当前数据库的所有表
* `\d table_name`: 查看表结构定义
* `\du`: 列出所有角色/用户
* `\dn`: 列出所有 Schema
* `\df`: 列出所有函数

---

## 2. 数据库操作 (Database)

```sql
-- 创建数据库
CREATE DATABASE db_name
WITH ENCODING = 'UTF8'
OWNER = user_name;

-- 删除数据库
DROP DATABASE IF EXISTS db_name;

-- 修改数据库名
ALTER DATABASE old_name RENAME TO new_name;
```

---

## 3. 架构操作 (Schema)

PostgreSQL 支持在数据库内创建多个 Schema，用于逻辑隔离，类似于文件夹。

```sql
-- 创建 Schema
CREATE SCHEMA IF NOT EXISTS myschema AUTHORIZATION user_name;

-- 设置当前会话的搜索路径
SET search_path TO myschema, public;
```

---

## 4. 数据表操作 (Table)

### 4.1 创建表 (常用数据类型)

```sql
CREATE TABLE users (
  -- 使用 BIGSERIAL 定义自增主键
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email TEXT,
  -- JSONB 支持高效索引
  profile_data JSONB,
  -- 带时区的日期时间
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

### 4.2 修改表结构

```sql
-- 添加列
ALTER TABLE users ADD COLUMN age INT;

-- 修改列类型
ALTER TABLE users ALTER COLUMN email TYPE VARCHAR(255);

-- 删除列
ALTER TABLE users DROP COLUMN age;
```

---

## 5. 数据操作 (DML)

### 5.1 插入并处理冲突 (Upsert)

这是 PostgreSQL 非常强大的特性：

```sql
INSERT INTO users (username, email)
VALUES ('dbroot', 'test@example.com')
ON CONFLICT (username)
DO UPDATE SET email = EXCLUDED.email;
```

### 5.2 分页查询

```sql
SELECT * FROM users
ORDER BY created_at DESC
LIMIT 10 OFFSET 20;
```

---

## 6. 索引 (Index)

### 6.1 基础索引

```sql
-- 普通 B-Tree 索引
CREATE INDEX idx_users_username ON users(username);

-- 唯一索引
CREATE UNIQUE INDEX uk_users_email ON users(email);
```

### 6.2 高级索引 (架构师关注)

```sql
-- 覆盖索引 (Index Only Scan)
CREATE INDEX idx_users_email_inc ON users(email) INCLUDE (username);

-- 部分索引 (仅对满足条件的数据建索引，节省空间)
CREATE INDEX idx_users_active ON users(created_at) WHERE active IS TRUE;

-- JSONB 索引 (GIN 索引)
CREATE INDEX idx_users_profile ON users USING GIN (profile_data);
```

---

## 7. 维护与性能

### 7.1 查看运行中的查询

```sql
SELECT pid, state, query, query_start
FROM pg_stat_activity
WHERE state != 'idle';

-- 终止长时间运行的查询
SELECT pg_cancel_backend(pid); -- 友好取消
SELECT pg_terminate_backend(pid); -- 强制杀掉连接
```

### 7.2 分析执行计划

```sql
-- 查看扫描方式及开销
EXPLAIN ANALYZE
SELECT * FROM users WHERE username = 'dbroot';
```

---

## 8. 备份与恢复

```bash
# 备份单个数据库
pg_dump -U username -d dbname > backup.sql

# 恢复数据库
psql -U username -d dbname < backup.sql

# 备份所有数据库（包括角色和表空间）
pg_dumpall -U postgres > all_backup.sql
```
