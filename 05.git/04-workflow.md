# 04 | Git 协作模式与推荐工作流

本模块介绍主流 Git 协作方式，包括 Git Flow、Fork + PR、Feature Branch 模式等，适用于团队开发与开源协作。

---

## 🌿 Git Flow 模型（推荐）

- `main`：仅保留生产部署代码
- `develop`：日常开发主分支
- `feature/*`：新功能
- `release/*`：预发布版本
- `hotfix/*`：生产紧急修复

---

## 🧪 常见命令流

```bash
git checkout -b feature/login
# 开发中…
git push origin feature/login
# 发起合并请求（Pull Request）
```

---

## 🔧 提交规范建议（约定式提交）

```bash
feat: 添加用户注册模块
fix: 修复 token 过期判断逻辑
docs: 更新 README 文档
refactor: 重构路由处理逻辑
```

---

## 🤝 PR 协作流程

- Fork 项目
- 提交分支
- 发起 Pull Request（PR）
- 审核后合并至主仓库
