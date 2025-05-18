# MYSQL FOREIGN KEY

在 `MySQL` 中，`FOREIGN KEY` 约束通过 `ON UPDATE` 和 `ON DELETE` 子句提供了几种具体的参照操作（Referential Actions），用于定义当父表中的数据被更新或删除时，子表中的相关数据如何响应。

eg

```sql
ALTER TABLE <TABLE_NAME>
    ADD CONSTRAINT <FK_NAME>
        FOREIGN KEY (<INNER_KEY>) REFERENCES <TABLE_NAME> (OUTER_KEY)
            ON DELETE CASCADE;
```

T-SQL

```sql
ALTER TABLE DEMO_TABLE
    ADD CONSTRAINT fk_parent_id_id
        FOREIGN KEY (parent_id) REFERENCES DEMO_TABLE (id)
            ON DELETE CASCADE;
```

| 操作          | ON DELETE                     | ON UPDATE                     | 说明                                      |
| :------------ | :---------------------------- | :---------------------------- | :---------------------------------------- |
| `RESTRICT`    | 父行有子行时，阻止删除父行    | 父行有子行时，阻止更新父行    | 最严格，强制维护参照完整性。              |
| `CASCADE`     | 删除父行时，级联删除子行      | 更新父行时，级联更新子行      | 父表的更改传播到子表，数据一致性强。      |
| `SET NULL`    | 删除父行时，子行外键设为 NULL | 更新父行时，子行外键设为 NULL | 断开关联，保留子数据，外键列需允许 NULL。 |
| `NO ACTION`   | 行为同 RESTRICT               | 行为同 RESTRICT               | SQL 标准，但在 MySQL 中等效于 RESTRICT。  |
| `SET DEFAULT` | MySQL 不支持                  | MySQL 不支持                  | 无法将外键设置为默认值。                  |

## RESTRICT (默认行为)

- `ON DELETE RESTRICT:` 如果父表中要删除的行在子表中有匹配的行，则不允许删除父表中的行。操作被限制（拒绝）。
- `ON UPDATE RESTRICT:` 如果父表中要更新的行的主键值在子表中有匹配的行，则不允许更新父表中的行。操作被限制（拒绝）。
- 特点: 强制保持参照完整性，不允许任何可能破坏引用关系的操作。

## CASCADE

- `ON DELETE CASCADE:` 当父表中的行被删除时，子表中所有匹配的行也会被自动删除。
- `ON UPDATE CASCADE:` 当父表中行的主键值被更新时，子表中所有匹配的行的外键值也会被自动更新以匹配新的主键值。
- 特点: 级联操作，父表的更改会“传播”到子表。常用于父子关系紧密，子数据依赖于父数据存在的情况。

## SET NULL

- `ON DELETE SET NULL:` 当父表中的行被删除时，子表中所有匹配行的外键列的值会被设置为 NULL。
- `ON UPDATE SET NULL:` 当父表中行的主键值被更新时，子表中所有匹配行的外键列的值会被设置为 NULL。
- 前提: 外键列必须允许为 NULL。
- 特点: 断开父子关系，但保留子表中的数据（只是外键关联丢失）。

## NO ACTION

- `ON DELETE NO ACTION:` 这是 SQL 标准中的关键字。在 MySQL 中，它的行为与 `RESTRICT` 完全相同。它表示如果父表中要删除或更新的行在子表中有匹配的行，则不允许删除或更新父表中的行。MySQL 立即检查外键约束，所以 `NO ACTION` 无法实现“延迟检查”的功能，因此与 `RESTRICT` 等效。
- `ON UPDATE NO ACTION:` 与 `ON UPDATE RESTRICT` 行为相同。
- 特点: 语义上与 RESTRICT 相同，即不允许破坏参照完整性的操作。

## SET DEFAULT

- MySQL 不支持 `SET DEFAULT` 参照操作。这意味着当父表中的行被删除或更新时，你不能将子表中的外键列设置为其默认值。

## 如何选择

- `RESTRICT` (或 NO ACTION): 当你希望严格控制数据，不允许任何可能破坏关系的操作时使用。这通常意味着你需要先手动处理子表数据（例如，删除或重新分配），然后才能对父表进行操作。
- `CASCADE:` 当父子关系非常紧密，子表数据完全依赖于父表存在时使用。例如，订单头和订单项，删除订单头时通常也需要删除所有订单项。
- `SET NULL:` 当子表中的数据即使失去了父表的引用也能独立存在时使用。例如，一个员工表有一个外键指向部门表，当部门被删除时，你可能希望将这些员工的部门ID设置为 NULL，而不是删除员工记录。
