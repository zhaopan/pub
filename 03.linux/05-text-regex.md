# 05 | 文本处理与正则技巧

本模块整理了 Linux 系统中用于文本提取、过滤、转换的核心命令，包含 `grep`、`sed`、`awk`、`cut`、`sort`、`uniq` 等，适用于日志排查、配置文件修改、数据管道脚本等场景。

> 📌 注：大量命令为历史脚本片段或排查日志时总结，请务必保留注释！

---

## 🔍 grep：文本搜索

```bash
grep "ERROR" app.log                         # 查找包含 ERROR 的行
grep -rn "token" ./src                       # 递归查找目录中的匹配项
grep -v "^#" /etc/nginx/nginx.conf           # 排除注释行
```

---

## ✂️ cut：按列切割

```bash
cat /etc/passwd | cut -d ':' -f1             # 获取所有用户名
df -h | grep "/dev" | cut -d ' ' -f1         # 仅提取设备名称（⚠️ 空格分隔需注意多空格）
```

---

## 🔄 sort / uniq：去重 + 排序组合拳

```bash
sort users.txt | uniq                        # 对用户列表去重
cat access.log | cut -d ' ' -f1 | sort | uniq -c | sort -nr
# 统计 IP 访问频次并倒序输出
```

---

## 🧙 sed：行内替换 & 多行匹配

```bash
sed 's/localhost/127.0.0.1/g' nginx.conf     # 将 localhost 全部替换为 IP
sed -n '5,10p' app.log                       # 打印第 5~10 行
sed '/^$/d' file.txt                         # 删除空行
```

---

## 🧠 awk：字段级提取神器

```bash
awk '{print $1, $3}' /etc/passwd             # 输出第 1 和第 3 列
df -h | awk 'NR>1 {print $1, $5}'            # 跳过表头，输出挂载点和磁盘使用率
awk -F ':' '{print $1}' /etc/passwd          # 使用冒号作为分隔符，输出用户名
```

---

## 🧪 综合使用示例

```bash
cat nginx.log | grep "404" | awk '{print $1}' | sort | uniq -c | sort -nr | head
# 统计触发 404 的来源 IP 排名前几名
```

---

## 🧠 历史注释说明

- `grep -rn` 是你排查前端项目 token 字样泄露的利器
- `awk` 是分析 nginx 日志时最常用的提取方式（尤其是 `$7`：请求路径）
- `sed '/^$/d'` 曾用于清理自动生成脚本中的模板空行
- `uniq -c | sort -nr` 是排查攻击来源（DDOS、IP）用的统计法宝

---

> 📁 下一模块：Shell 脚本片段 → [06-shell-snippets.md](./06-shell-snippets.md)
