# 03 | 历史操作与问题排查

本模块介绍 Git 历史回溯相关命令，包括 `reset`、`revert`、`stash`、`diff`，适用于异常恢复与问题定位。

---

## 🔄 回退操作

```bash
git reset --soft HEAD^            # 回退提交但保留变更
git reset --hard HEAD~2           # 强制回退 2 次提交并清除变更
```

> ⚠️ 使用 `--hard` 后无法找回，请谨慎操作！

---

## 🔁 代码暂存与恢复

```bash
git stash                         # 暂存当前改动
git stash list                    # 查看所有暂存项
git stash pop                     # 恢复最近一次暂存
```

---

## 🔍 差异对比

```bash
git diff                          # 工作区 vs 暂存区
git diff --cached                 # 暂存区 vs 上次 commit
```

---

## 🧪 错误恢复示例

```bash
git revert <commit>              # 撤销某次提交并新建一次反向提交
```
