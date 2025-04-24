# 01 | Git 基础命令实践

本模块覆盖 Git 最常用的基础操作命令，适合初学者与日常开发使用，掌握 Git 的核心版本控制逻辑。

---

## 📦 常用命令速查

```bash
git clone <url>                   # 克隆远程仓库
git status                        # 查看当前变更状态
git add <file>                    # 暂存文件
git commit -m "message"           # 提交变更
git push origin main              # 推送到远程主分支
git pull origin main              # 拉取远程主分支更新
```

---

## 🧪 实战场景示例

### ✅ 场景：提交一个功能修改

```bash
git status
git add .
git commit -m "feat: 新增用户登录功能"
git push origin dev
```

### ✅ 场景：克隆远程项目

```bash
git clone git@github.com:example/project.git
cd project
```
