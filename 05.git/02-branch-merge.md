# 02 | 分支管理与合并策略

本模块介绍 Git 中常用的分支操作，包含创建、切换、合并、rebase、删除等，适用于多分支协作开发。

---

## 🧭 核心命令

```bash
git branch                         # 查看本地分支
git checkout -b dev                # 创建并切换新分支
git switch main                    # 新版命令切换分支
git merge feature/login            # 合并分支
git rebase main                    # 变基操作（更清晰历史）
git branch -d <name>               # 删除本地分支
```

---

## 🌲 分支图常见策略

- `main` 主分支（稳定）
- `dev` 日常开发分支
- `feature/*` 功能开发
- `bugfix/*` 修复分支
- `release/*` 发布分支

---

## 🧪 合并实战示例

```bash
git checkout dev
git merge feature/login
```

或者使用：

```bash
git rebase main
```
