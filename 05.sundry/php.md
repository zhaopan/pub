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
