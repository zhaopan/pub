# vs自定义项目和项模板

`模板路径`：%vsroot%\Microsoft Visual Studio\\Enterprise\Common7\IDE\ItemTemplates

## 示例

```csharp
/*
 * Copyright (c) $year$ ZP
 * Revision: 2.1
 * CLR: $clrversion$
 * Date $time$
 * Name $safeitemrootname$
 * Create on device $machinename$.$username$
 * Author Create By ZHAOPAN
 * Describe something
 *
 */
```

## 模板保留参数

```bash
# clrversion
公共语言运行时 (CLR) 的当前版本。

# ext_*
将 ext_ 前缀添加到任何参数，以引用父模板的变量。 例如 ext_safeprojectname。

# guid
[1-10]  一个用于替换项目文件中的项目 GUID 的 GUID。 可指定最多 10 个唯一的 GUID（例如，guid1）。

# itemname
在其中使用参数的文件的名称。

# machinename
当前的计算机名称（例如，Computer01）。

# projectname
创建项目时由用户提供的名称。

# registeredorganization
来自 HKLM\Software\Microsoft\Windows NT\CurrentVersion\RegisteredOrganization 的注册表项值。

# rootnamespace
当前项目的根命名空间。 此参数仅适用于项模板。

# safeitemname
与 itemname 相同，但所有不安全字符和空格替换为了下划线。

# safeitemrootname
与 safeitemname 相同。

# safeprojectname
用户在创建项目时提供的名称，但名称中删除了所有不安全字符和空格。

# time
以 DD/MM/YYYY 00:00:00 格式表示的当前时间。

# specifiedSolutionName
解决方案的名称。 在选中“创建解决方案目录”时，specifiedSolutionName 具有解决方案名称。 在未选中“创建解决方案目录”时，specifiedSolutionName 为空。

# userdomain
当前的用户域。

# username
当前的用户名称。

# webnamespace
当前网站的名称。 此参数在 Web 窗体模板中用于保证类名是唯一的。 如果网站在 Web 服务器的根目录下，则此模板参数解析为 Web 服务器的根目录。

# year
以 YYYY 格式表示的当前年份
```

## 参考URL

[vs2019](https://docs.microsoft.com/zh-cn/visualstudio/ide/template-parameters?view=vs-2019)

[dotnet](https://docs.microsoft.com/zh-cn/dotnet/core/tools/custom-templates)
