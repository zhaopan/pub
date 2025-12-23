# GitHub CLI (gh) 学习文档

> GitHub 官方命令行工具，用于在终端中操作 GitHub

## 目录

- [简介](#简介)
- [安装](#安装)
- [基础配置](#基础配置)
- [仓库操作](#仓库操作)
- [GitHub Actions 管理](#github-actions-管理)
- [Issue 和 PR 管理](#issue-和-pr-管理)
- [常用技巧](#常用技巧)

---

## 简介

GitHub CLI (`gh`) 是 GitHub 的官方命令行工具，允许你在终端中执行 GitHub 操作，无需访问网页界面。

### 主要功能

- 管理仓库、Issue、Pull Request
- 查看和管理 GitHub Actions 工作流
- 创建和管理 Gist
- 查看通知和用户信息

---

## 安装

### Windows

```bash
# 使用 Scoop
scoop install gh

# 使用 Chocolatey
choco install gh
```

### macOS

```bash
# 使用 Homebrew
brew install gh
```

### Linux

```bash
# Debian/Ubuntu
sudo apt install gh

# Fedora/CentOS
sudo dnf install gh
```

### 验证安装

```bash
gh --version
```

---

## 基础配置

### 登录认证

```bash
# 交互式登录
gh auth login

# 查看登录状态
gh auth status

# 登出
gh auth logout
```

### 配置默认编辑器

```bash
# 设置默认编辑器
gh config set editor vim

# 查看当前配置
gh config list
```

---

## 仓库操作

### 查看仓库列表

```bash
# 列出你的所有仓库
gh repo list

# 列出指定用户的仓库
gh repo list <username>

# 限制数量
gh repo list --limit 1000

# 仅显示源仓库（非 fork）
gh repo list --source

# JSON 格式输出
gh repo list --json nameWithOwner -q '.[].nameWithOwner'
```

### 克隆仓库

```bash
# 克隆仓库
gh repo clone <owner>/<repo>

# 克隆到指定目录
gh repo clone <owner>/<repo> <directory>
```

### 创建仓库

```bash
# 交互式创建
gh repo create

# 创建公开仓库
gh repo create <name> --public

# 创建私有仓库
gh repo create <name> --private
```

### 查看仓库信息

```bash
# 查看当前仓库
gh repo view

# 查看指定仓库
gh repo view <owner>/<repo>

# 在浏览器中打开
gh repo view --web
```

---

## GitHub Actions 管理

### 查看工作流运行记录

```bash
# 列出所有运行记录
gh run list

# 列出失败的运行记录
gh run list --status failure

# 限制显示数量
gh run list --limit 100

# 指定仓库
gh run list --repo <owner>/<repo>

# JSON 格式输出
gh run list --json databaseId,status,conclusion -q '.[]'
```

### 查看运行详情

```bash
# 查看指定运行的详情
gh run view <run-id>

# 查看日志
gh run view <run-id> --log

# 在浏览器中打开
gh run view <run-id> --web
```

### 删除工作流运行记录

```bash
# 删除指定运行记录
gh run delete <run-id>

# 删除指定仓库的运行记录
gh run delete <run-id> --repo <owner>/<repo>
```

### 重新运行工作流

```bash
# 重新运行
gh run rerun <run-id>

# 重新运行失败的作业
gh run rerun <run-id> --failed
```

### 清理失败的 Actions 记录

#### 方法 1: 清理当前仓库的失败记录

```bash
# 清理当前目录仓库所有失败记录
gh run list --status failure --limit 100 --json databaseId -q '.[].databaseId' | xargs -r -I{} gh run delete {}
```

#### 方法 2: 批量清理所有仓库的失败记录（使用 while 循环）

```bash
# 适用于 Git Bash 或 Linux
gh repo list --limit 1000 --json nameWithOwner --source -q '.[].nameWithOwner' | while read repo; do
  echo ">>> 正在清理仓库: $repo"
  ids=$(gh run list --repo "$repo" --status failure --limit 100 --json databaseId -q '.[].databaseId')
  if [ -n "$ids" ]; then
    echo "$ids" | xargs -I{} gh run delete --repo "$repo" {}
    echo ">>> 清理完成。"
  else
    echo ">>> 没有发现失败记录。"
  fi
done
```

#### 方法 3: 批量清理所有仓库的失败记录（使用 awk）

```bash
# 更简洁的版本，适用于 Linux/macOS
gh repo list --limit 1000 --source | awk '{print $1}' | while read repo; do
  echo ">>> 正在清理仓库: $repo"
  gh run list --repo "$repo" --status failure --limit 100 --json databaseId -q '.[].databaseId' | xargs -r -I{} gh run delete --repo "$repo" {}
done
```

---

## Issue 和 PR 管理

### Issue 操作

```bash
# 列出 Issue
gh issue list

# 创建 Issue
gh issue create

# 查看 Issue 详情
gh issue view <issue-number>

# 关闭 Issue
gh issue close <issue-number>

# 重新打开 Issue
gh issue reopen <issue-number>
```

### Pull Request 操作

```bash
# 列出 PR
gh pr list

# 创建 PR
gh pr create

# 查看 PR 详情
gh pr view <pr-number>

# 检出 PR
gh pr checkout <pr-number>

# 合并 PR
gh pr merge <pr-number>

# 审查 PR
gh pr review <pr-number> --approve
gh pr review <pr-number> --request-changes
gh pr review <pr-number> --comment
```

---

## 常用技巧

### JSON 查询 (jq 风格)

```bash
# 使用 -q 参数进行 jq 风格查询
gh repo list --json name,owner -q '.[] | select(.owner.login == "username")'

# 获取特定字段
gh run list --json databaseId,status,conclusion -q '.[] | {id: .databaseId, status: .status}'
```

### 别名设置

```bash
# 设置别名
gh alias set prs 'pr list'
gh alias set issues 'issue list'

# 查看所有别名
gh alias list

# 删除别名
gh alias delete prs
```

### 在浏览器中打开

```bash
# 大多数命令支持 --web 参数在浏览器中打开
gh repo view --web
gh issue view <issue-number> --web
gh pr view <pr-number> --web
gh run view <run-id> --web
```

### 批处理技巧

```bash
# 组合使用管道和 xargs
gh repo list --json nameWithOwner -q '.[].nameWithOwner' | xargs -I{} gh repo view {}

# 过滤并处理
gh run list --status failure --json databaseId -q '.[].databaseId' | head -10 | xargs -I{} gh run delete {}
```

---

## 参考资料

- [GitHub CLI 官方文档](https://cli.github.com/manual/)
- [GitHub CLI 仓库](https://github.com/cli/cli)
- [GitHub Actions 文档](https://docs.github.com/actions)

---

## 更新日志

- 2025-12-23: 整理并完善文档结构
- 添加了完整的章节分类和示例代码
