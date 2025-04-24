# foo

## 常用

```bash
# install.sh 每行以\r结尾，解决 windows 下行尾序列异常
sed -i 's/\r$//' install.sh

# dos2unix 工具
# dos2unix 工具非常简单易用，其主要功能就是将文本文件中的 Windows 风格的换行符 (CR LF) 转换为 Unix/Linux 风格的换行符 (LF)

# 直接修改 install.sh 文件，将其中的 Windows 换行符转换为 Unix 换行符。
dos2unix install.sh

# 将 install.sh 转换后的内容保存到 output.sh 文件中，原始的 install.sh 文件不会被修改。
dos2unix -n install.sh output.sh

# 一次指定多个文件名，dos2unix 会依次处理它们。
dos2unix file1.txt file2.sh file3.c

# -k 或 --keepdate: 保留输出文件的最后修改时间与输入文件相同。默认情况下，dos2unix 会更新输出文件的修改时间。
dos2unix -k install.sh

# -o 或 --old-file: 这是默认行为，直接在原始文件上进行转换。
dos2unix -o install.sh

# -f 或 --force: 强制转换，即使输入文件看起来不像 DOS 文本文件。
dos2unix -f install.sh

# -q 或 --quiet: 静默模式，不显示任何警告或信息。
dos2unix -q install.sh

# -v 或 --verbose: 显示详细的转换信息。
dos2unix -v install.sh
```
