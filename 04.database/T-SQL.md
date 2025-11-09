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

## 重命名某些列

```sql
SELECT t.table_name AS '表名',
       -- 拼接出最终要执行的 ALTER TABLE RENAME COLUMN 语句 (批量重命名)
       CONCAT(
               'ALTER TABLE `',
               t.table_schema,
               '`.`',
               t.table_name,
               '` ',
           -- 将所有要修改的的列用 GROUP_CONCAT 连接起来
               GROUP_CONCAT(
                       CONCAT('RENAME COLUMN `', t.column_name,'`',' TO ' ,f_format(t.column_name))
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

## 支持函数 `f_format`

```sql
DELIMITER $$

-- 检查并删除已存在的函数（如果需要重新创建）
DROP FUNCTION IF EXISTS f_format$$

-- 创建 f_format 函数
CREATE FUNCTION f_format(input_string VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE result_string VARCHAR(255);
    DECLARE underscore_pos INT;
    
    -- 1. 初始化结果字符串
    SET result_string = input_string;

    -- 2. 处理首字母大写
    IF LENGTH(result_string) > 0 THEN
        SET result_string = CONCAT(
            UPPER(SUBSTRING(result_string, 1, 1)), 
            SUBSTRING(result_string, 2)
        );
    END IF;

    -- 3. 循环查找并处理下划线
    SET underscore_pos = LOCATE('_', result_string);

    WHILE underscore_pos > 0 DO
        -- 确保下划线后有字符可以处理
        IF underscore_pos < LENGTH(result_string) THEN
            -- 3a. 移除下划线前的部分（到下划线位置）
            -- 3b. 将下划线后的第一个字符转为大写
            -- 3c. 拼接剩余部分
            SET result_string = CONCAT(
                SUBSTRING(result_string, 1, underscore_pos - 1), 
                UPPER(SUBSTRING(result_string, underscore_pos + 1, 1)),
                SUBSTRING(result_string, underscore_pos + 2)
            );
        ELSE
            -- 如果下划线是最后一个字符，直接移除
            SET result_string = SUBSTRING(result_string, 1, underscore_pos - 1);
        END IF;

        -- 查找下一个下划线的位置
        SET underscore_pos = LOCATE('_', result_string);
    END WHILE;

    -- 4. 返回最终结果
    RETURN result_string;
END$$

DELIMITER ;
```

## 全值匹配 更新配置表

### sys_source_fields

```sql
UPDATE
    sys_source_fields AS TargetField
INNER JOIN
    -- MatchingUpdateData: 匹配到的需要更新的数据集
    (
        SELECT
            SourceFieldMatch.Id AS TargetRecordId,
            SchemaColumn.column_name AS NewFieldCode
        FROM
            -- SourceFieldMatch: 找出 sys_source_fields 中需要匹配的记录
            (
                SELECT
                    Field.Id,
                    List.SourceConfig,
                    Field.FieldCode
                FROM
                    sys_source_list AS List
                    INNER JOIN sys_source_fields AS Field ON List.Id = Field.SourceId
            ) AS SourceFieldMatch
        INNER JOIN
            -- SchemaColumn: 找出 information_schema 中实际存在的表和字段
            (
                SELECT
                    c.table_name,
                    c.column_name
                FROM
                    information_schema.COLUMNS c
                INNER JOIN
                    information_schema.TABLES tb ON c.table_schema = tb.table_schema
                    AND c.table_name = tb.table_name
                    AND c.table_schema = DATABASE()
                    AND tb.table_type = 'BASE TABLE'
            ) AS SchemaColumn
            -- 匹配条件：SourceConfig (表名) = table_name AND FieldCode (旧字段名) = column_name (新字段名)
            ON SourceFieldMatch.SourceConfig = SchemaColumn.table_name
            AND SourceFieldMatch.FieldCode = SchemaColumn.column_name
    ) AS MatchingUpdateData
    -- 关联：使用 Id 将结果集与目标表 sys_source_fields 连接
    ON TargetField.Id = MatchingUpdateData.TargetRecordId
SET
    TargetField.FieldCode = MatchingUpdateData.NewFieldCode;
```

### sys_form_fields

```sql
UPDATE
    sys_form_fields AS TargetField
INNER JOIN
    -- MatchingUpdateData: 匹配到的需要更新的数据集
    (
    -- MatchingUpdateData: 匹配到的需要更新的数据集

        SELECT
            SourceFieldMatch.Id AS TargetRecordId,
            SourceFieldMatch.SourceConfig,
            SourceFieldMatch.FieldCode AS OldFieldCode,
            SchemaColumn.column_name AS NewFieldCode
        FROM
            -- SourceFieldMatch: 找出 sys_source_fields 中需要匹配的记录
            (
                SELECT
                    Field.Id,
                    Field.FieldCode,
                    slist.SourceConfig
                FROM sys_form_list AS List 
                    INNER JOIN sys_form_fields AS Field ON List.Id = Field.FormId
                    INNER JOIN sys_source_list AS slist ON slist.ModuleId = List.ModuleId
            ) AS SourceFieldMatch
        INNER JOIN
            -- SchemaColumn: 找出 information_schema 中实际存在的表和字段
            (
                SELECT
                    c.table_name,
                    c.column_name
                FROM
                    information_schema.COLUMNS c
                INNER JOIN
                    information_schema.TABLES tb ON c.table_schema = tb.table_schema
                    AND c.table_name = tb.table_name
                    AND c.table_schema = DATABASE()
                    AND tb.table_type = 'VIEW'
            ) AS SchemaColumn
            ON SourceFieldMatch.SourceConfig = SchemaColumn.table_name
            AND SourceFieldMatch.FieldCode = SchemaColumn.column_name
    ) AS MatchingUpdateData
    -- 关联：使用 Id 将结果集与目标表 sys_source_fields 连接
    ON TargetField.Id = MatchingUpdateData.TargetRecordId
SET
    TargetField.FieldCode = MatchingUpdateData.NewFieldCode;
```

## 查询有小写字段的表和字段

```sql
SELECT
    t.table_schema AS '数据库名',
    t.table_name AS '表名',
    t.column_name AS '字段名'
FROM
    information_schema.columns t
WHERE
    t.table_schema = DATABASE() -- 仅查询当前数据库
    -- 核心逻辑：检查字段名的第一个字符的 ASCII 值是否在 97 到 122 之间 (即 a-z)
    AND ASCII(LEFT(t.column_name, 1)) BETWEEN 97 AND 122
ORDER BY
    t.table_name,
    t.column_name;
```
