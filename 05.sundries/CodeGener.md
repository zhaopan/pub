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

---

## 代码生成工具免责声明 (Disclaimer for Code Generation Tool)

**适用于：** `pub/05.sundries/CodeGener.md` 及相关代码生成工具和模板

---

### 1. 目的与限制

本免责声明旨在明确说明本代码生成工具（“工具”）及其所有关联文件和模板（包括但不限于 CodeSmith 模板、脚本、配置文件等）的使用限制和风险。本工具的创建旨在提高开发效率，**自动生成**重复性的代码结构。

### 2. 无保证声明

* **不提供任何明示或暗示的保证。** 本工具及所生成的代码以“现状”（AS IS）提供，不附带任何类型的明示或暗示保证，包括但不限于适销性、特定用途适用性、所有权、非侵权性以及代码的准确性、完整性或可靠性。
* **不保证零错误。** 尽管作者已尽力确保工具的质量，但不能保证其生成的代码是完全正确的、无错误的，或能满足用户的全部业务需求。

### 3. 用户责任

* **代码审核是强制性的。** 用户必须对本工具生成的所有代码进行**严格、全面的审查和测试**。用户应承担因使用、修改或依赖生成的代码而产生的所有风险。
* **遵守法律法规。** 用户应确保其使用本工具及其生成的代码遵守所有适用的法律、法规和行业标准。

### 4. 责任限制

**在任何情况下，工具的作者或贡献者均不对任何直接的、间接的、附带的、特殊的、惩罚性的、后果性的或任何其他类型的损害（包括但不限于利润损失、数据丢失、业务中断等）承担责任，** 即使已被告知发生此类损害的可能性，这些损害包括但不限于：

* 因使用或无法使用本工具而造成的损失。
* 因依赖本工具生成的代码的准确性或可靠性而造成的损失。
* 因工具或生成的代码中的缺陷、错误、遗漏、中断或操作延迟而造成的损失。

### 5. 许可与权利

本工具及其相关文档受原始许可（如 GitHub 仓库所示的许可证）的约束。用户应遵守该许可证规定的使用和分发条款。

**通过使用本工具，您即表示已阅读、理解并同意本免责声明的所有条款。**

