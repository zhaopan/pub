# T-SQL

MYSQL-8.0

## 更新某些字段(带下划线)

```sql
SELECT t.table_name AS '表名',
       -- GROUP_CONCAT 聚合函数，用于生成完整的 UPDATE 语句
       CONCAT(
               'UPDATE `',
               t.table_schema,
               '`.`',
               t.table_name,
               '` SET ',
               GROUP_CONCAT(
                       CONCAT(
                               '`',
                           -- 目标字段名 (仅移除下划线): 使用 REPLACE
                               REPLACE(t.column_name, '_', ''),
                               '` = `',
                               t.column_name, -- 数据来源字段 (snake_case)
                               '`'
                       )
                       ORDER BY t.ordinal_position ASC
                       SEPARATOR ', '
               ),
               ';'
       )            AS update_migration_script
FROM information_schema.columns AS t
         INNER JOIN information_schema.tables tb
                    ON t.table_schema = tb.table_schema AND t.table_name = tb.table_name
WHERE tb.table_type = 'BASE TABLE' -- 只查询普通表 (排除 VIEW)
  AND t.table_schema = DATABASE()  -- 替换为你的数据库名
  AND t.column_name LIKE '%\\_%'
GROUP BY t.table_schema,
         t.table_name
ORDER BY t.table_name;
```

## 查找关联到某表的外键

```sql
SELECT t.table_schema    AS '外键所在数据库',
       t.table_name      AS '子表名称',
       t.column_name     AS '子表外键列',
       t.constraint_name AS '外键约束名',
       CONCAT(
               'ALTER TABLE `',
               t.table_name,
               '` DROP FOREIGN KEY `',
               t.constraint_name,
               '`;'
       )                 AS drop_constraint_command
FROM information_schema.key_column_usage AS t
WHERE t.referenced_table_name = '<your_table_name>' -- 目标表名（父表）
  AND t.referenced_table_schema = DATABASE()        -- 替换为你的数据库名
  AND t.referenced_table_name IS NOT NULL           -- 确保是外键
ORDER BY t.table_name;
```

## 查询没有主键的表

```sql
SELECT t.table_schema AS databasename,
       t.table_name   AS tablewithoutprimarykey
FROM information_schema.tables t
         LEFT JOIN information_schema.table_constraints tco ON t.table_schema = tco.table_schema
    AND t.table_name = tco.table_name
    AND tco.constraint_type = 'PRIMARY KEY'
WHERE tco.constraint_type IS NULL                                                        -- 筛选出没有 PRIMARY KEY 约束的记录
  AND t.table_schema = DATABASE()                                                        -- 替换为你的数据库名
  AND t.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') -- 排除系统数据库
  AND t.table_type = 'BASE TABLE'                                                        -- 只查询普通表 (排除 VIEW)
ORDER BY t.table_name;
```

## 删除某些列

```sql
SELECT t.table_name AS '表名',
       -- 拼接出最终要执行的 ALTER TABLE DROP COLUMN 语句 (批量删除)
       CONCAT(
               'ALTER TABLE `',
               t.table_schema,
               '`.`',
               t.table_name,
               '` ',
           -- 将所有要删除的列用 GROUP_CONCAT 连接起来
               GROUP_CONCAT(
                       CONCAT('DROP COLUMN `', t.column_name, '`')
                       ORDER BY t.ordinal_position ASC
                       SEPARATOR ', '
               ),
               ';'
       )            AS drop_command_batch
FROM information_schema.columns t
         INNER JOIN information_schema.tables tb
                    ON t.table_schema = tb.table_schema AND t.table_name = tb.table_name
WHERE tb.table_type = 'BASE TABLE' -- 仅操作普通表
  AND t.table_schema = DATABASE()  -- 目标数据库
  AND (t.column_name IN ('create_at', 'update_at', 'delete_at') -- 指定名字的
    OR t.column_name LIKE '%\_%' -- 带下划线的
    )
GROUP BY t.table_schema,
         t.table_name
ORDER BY t.table_name;
```
