# xargs

`xargs - build and execute command lines from standard input`

在使用find命令的-exec选项处理匹配到的文件时， find命令将所有匹配到的文件一起传递给exec执行。
但有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟之后，就会出现溢出错误。
错误信息通常是“参数列太长”或“参数列溢出”。
这就是xargs命令的用处所在，特别是与find命令一起使用。

find命令把匹配到的文件传递给xargs命令，而xargs命令每次只获取一部分文件而不是全部，不像-exec选项那样。
这样它可以先处理最先获取的一部分文件，然后是下一批，并如此继续下去。

在有些系统中，使用-exec选项会为处理每一个匹配到的文件而发起一个相应的进程，并非将匹配到的文件全部作为参数一次执行；
这样在有些情况下就会出现进程过多，系统性能下降的问题，因而效率不高；

而使用xargs命令则只有一个进程。
另外，在使用xargs命令时，究竟是一次获取所有的参数，还是分批取得参数，以及每一次获取参数的数目都会根据该命令的选项及系统内核中相应的可调参数来确定。

来看看xargs命令是如何同find命令一起使用的，并给出一些例子。

下面的例子查找系统中的每一个普通文件，然后使用xargs命令来测试它们分别属于哪类文件

```bash
$find . -type f -print | xargs file
./.kde/Autostart/Autorun.desktop: UTF-8 Unicode English text
./.kde/Autostart/.directory:      ISO-8859 text\
......
```

在整个系统中查找内存信息转储文件(core dump) ，然后把结果保存到/tmp/core.log 文件中：

```bash
$find / -name "core" -print | xargs echo "" >/tmp/core.log
```

上面这个执行太慢，我改成在当前目录下查找

```bash
$find . -name "file*" -print | xargs echo "" > /temp/core.log
$cat /temp/core.log
./file6
```

在当前目录下查找所有用户具有读、写和执行权限的文件，并收回相应的写权限：

```bash
$ls -l
drwxrwxrwx    2 sam      adm          4096 10月 30 20:14 file6
-rwxrwxrwx    2 sam      adm             0 10月 31 01:01 http3.conf
-rwxrwxrwx    2 sam      adm             0 10月 31 01:01 httpd.conf

$find . -perm -7 -print | xargs chmod o-w
$ls -l
drwxrwxr-x    2 sam      adm          4096 10月 30 20:14 file6
-rwxrwxr-x    2 sam      adm             0 10月 31 01:01 http3.conf
-rwxrwxr-x    2 sam      adm             0 10月 31 01:01 httpd.conf

用grep命令在所有的普通文件中搜索hostname这个词：
$find . -type f -print | xargs grep "hostname"
./httpd1.conf:#different IP addresses or hostnames and have them handled by the
./httpd1.conf:#VirtualHost: If you want to maintain multiple domains/hostnames on your

用grep命令在当前目录下的所有普通文件中搜索hostnames这个词：
$find . -name \* -type f -print | xargs grep "hostnames"
./httpd1.conf:#different IP addresses or hostnames and have them handled by the
./httpd1.conf:#VirtualHost: If you want to maintain multiple domains/hostnames on your
```

注意，在上面的例子中， \用来取消find命令中的*在shell中的特殊含义。

find命令配合使用exec和xargs可以使用户对所匹配到的文件执行几乎所有的命令。