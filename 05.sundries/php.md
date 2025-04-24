# php

## PHP中的empty、isset、isnull的区别与使用实例

### empty

如果 变量 是非空或非零的值，则 empty() 返回 FALSE。换句话说，""、0、"0″、NULL、FALSE、array()、var $var、未定义;以及没有任何属性的对象都将被认为是空的，如果 var 为空，则返回 TRUE。 代码示例：

```php
$a = 0;
$b = '';
$c = array();
if (empty($a)) echo '$a 为空' . "";
if (empty($b)) echo '$b 为空' . "";
if (empty($c)) echo '$c 为空' . "";
if (empty($d)) echo '$d 为空' . "";
// 以上输出皆为空
```

### isset

如果 变量 存在(非NULL)则返回 TRUE，否则返回 FALSE(包括未定义）。变量值设置为：null，返回也是false;unset一个变量后，变量被取消了。注意，isset对于NULL值变量，特殊处理。 代码示例：

```php
$a = '';
$a['c'] = '';
if (!isset($a)) echo '$a 未被初始化' . "";
if (!isset($b)) echo '$b 未被初始化' . "";
if (isset($a['c'])) echo '$a 已经被初始化' . "";
// 显示结果为
// $b 未被初始化
// $a 已经被初始化
```

### is_null

检测传入值【值，变量，表达式】是否是null,只有一个变量定义了，且它的值是null，它才返回TRUE . 其它都返回 FALSE 【未定义变量传入后会出错！】

```php
$a = null;
$b = false;
if (is_null($a)) echo '$a 为NULL' . "";
if (is_null($b)) echo '$b 为NULL' . "";
if (is_null($c)) echo '$c 为NULL' . "";
// 显示结果为
// $a 为NULL
// Undefined variable: c
```

### **==** 、**===**

#### `===` (全等比较)

- **数值比较:** 它比较两个操作数的实际内容或数值。
- **类型比较:** 它还会检查两个操作数的数据类型是否完全相同。
- **结果:** 只有当两个操作数的数值和数据类型都完全一致时，它才返回 `true`。否则，返回 `false`。

#### `==` (松散相等比较)

- **数值比较:** 它也比较两个操作数的数值。
- **类型转换:** 然而，如果两个操作数的数据类型不同，PHP 会尝试将其中一个或两个操作数转换为相同的类型，然后再进行比较。这被称为 **类型转换 (type juggling)** 或 类型强制转换 **(type coercion)**。
- **结果:** 如果在必要的类型转换之后，两个操作数的数值相等，它就返回 `true`。否则，返回 `false`。

```php
$a = 5;        // 整数
$b = "5";      // 字符串
$c = 5.0;      // 浮点数
$d = true;     // 布尔值 (true 通常会被强制转换为 1)
$e = false;    // 布尔值 (false 通常会被强制转换为 0)

// 使用 === (全等比较)
var_dump($a === $b); // 输出: bool(false) - 类型不同 (整数 vs. 字符串)
var_dump($a === $c); // 输出: bool(false) - 类型不同 (整数 vs. 浮点数)
var_dump($a === 5);   // 输出: bool(true)  - 数值和类型都相同 (整数)
var_dump($d === 1);   // 输出: bool(false) - 类型不同 (布尔值 vs. 整数)
var_dump($e === 0);   // 输出: bool(false) - 类型不同 (布尔值 vs. 整数)

// 使用 == (松散相等比较)
var_dump($a == $b);  // 输出: bool(true)  - 字符串 "5" 被强制转换为整数 5
var_dump($a == $c);  // 输出: bool(true)  - 浮点数 5.0 被强制转换为整数 5
var_dump($a == 5);    // 输出: bool(true)
var_dump($d == 1);    // 输出: bool(true)  - 布尔值 true 被强制转换为 1
var_dump($e == 0);    // 输出: bool(true)  - 布尔值 false 被强制转换为 0
```
