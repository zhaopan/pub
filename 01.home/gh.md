# GitHub CLI (gh) 进阶指南

> 从命令行掌控 GitHub 的完整工作流 - 适合进阶开发者

## 快速导航

### 核心功能
- [快速开始](#快速开始) - 安装、认证、配置
- [仓库管理](#仓库管理) - 创建、克隆、Fork、同步、批量操作
- [Pull Request 工作流](#pull-request-工作流) - 创建、审查、合并、自动化
- [Issue 管理](#issue-管理) - 创建、查询、批量处理
- [GitHub Actions](#github-actions) - Workflow 管理、清理、监控

### 进阶技能
- [GitHub API](#github-api) - REST API 和 GraphQL 高级查询
- [批量自动化](#批量自动化) - 跨仓库批处理、脚本模板
- [扩展生态](#扩展生态) - 实用扩展、自定义扩展
- [最佳实践](#最佳实践) - 性能优化、安全建议、团队协作

### 资源
- [实战场景](#实战场景) - 真实场景解决方案
- [常见问题](#常见问题) - 故障排查
- [速查表](#速查表) - 快速参考

---

## 快速开始

### 安装与升级

```bash
# Windows (推荐 Scoop)
scoop install gh
scoop update gh

# macOS
brew install gh
brew upgrade gh

# Linux (Debian/Ubuntu)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh

# 验证版本
gh --version
```

### 认证配置

```bash
# 交互式登录 (推荐)
gh auth login

# 使用 Token 登录
export GH_TOKEN="ghp_xxxxxxxxxxxx"
gh auth status

# 多账号管理
gh auth login --hostname github.com
gh auth login --hostname github.enterprise.com

# 切换账号
gh auth switch

# 刷新 Token
gh auth refresh -h github.com -s admin:org
```

### 环境配置

```bash
# 配置编辑器
gh config set editor "code --wait"  # VS Code
gh config set editor "vim"          # Vim
gh config set editor "nano"         # Nano

# 配置浏览器
gh config set browser "firefox"

# 配置 Git 协议
gh config set git_protocol ssh   # 使用 SSH (推荐)
gh config set git_protocol https # 使用 HTTPS

# 配置 Prompt (禁用交互式提示)
gh config set prompt disabled

# 查看所有配置
gh config list

# 配置文件位置
# Windows: %APPDATA%\GitHub CLI\config.yml
# Linux/macOS: ~/.config/gh/config.yml
```

### 实用别名配置

```bash
# Pull Request 相关
gh alias set co 'pr checkout'                    # 快速检出 PR
gh alias set pv 'pr view --web'                  # 浏览器查看 PR
gh alias set pc 'pr create --fill'               # 快速创建 PR
gh alias set prs 'pr list --author @me'          # 我的 PR

# Issue 相关
gh alias set iv 'issue view --web'               # 浏览器查看 Issue
gh alias set ic 'issue create'                   # 创建 Issue
gh alias set issues 'issue list --assignee @me'  # 我的 Issue

# Actions 相关
gh alias set runs 'run list --limit 5'           # 最近的运行
gh alias set failed 'run list --status failure'  # 失败的运行
gh alias set watch 'run watch'                   # 监控运行

# Repo 相关
gh alias set rv 'repo view --web'                # 浏览器查看仓库
gh alias set repos 'repo list --limit 100'       # 我的仓库

# 查看所有别名
gh alias list

# 别名支持参数传递
gh co 123  # 等同于 gh pr checkout 123
```

---

## 仓库管理

### 智能查询仓库

```bash
# 基础列表
gh repo list                           # 你的仓库
gh repo list <username>                # 指定用户
gh repo list <org-name>                # 组织仓库

# 高级筛选
gh repo list --source                  # 仅非 fork 仓库
gh repo list --public --source         # 公开源仓库
gh repo list --private --limit 50      # 前 50 个私有仓库
gh repo list --language Go --source    # Go 语言仓库
gh repo list --archived                # 已归档仓库
gh repo list --fork                    # 仅 fork 仓库

# 按活跃度排序
gh repo list --sort updated            # 最近更新
gh repo list --sort created            # 最新创建
gh repo list --sort pushed             # 最近推送
gh repo list --sort full_name          # 按名称

# 格式化输出
gh repo list --json nameWithOwner,stargazerCount,updatedAt,isPrivate |
  jq -r '.[] | "\(.nameWithOwner) | Stars: \(.stargazerCount) | \(.updatedAt[:10])"'

# 导出仓库列表
gh repo list --limit 1000 --json nameWithOwner -q '.[].nameWithOwner' > repos.txt
```

### 高效克隆仓库

```bash
# 基础克隆（自动识别 SSH/HTTPS）
gh repo clone <owner>/<repo>
gh repo clone <owner>/<repo> <directory>

# 批量克隆策略
# 1. 克隆组织所有源仓库（跳过 fork）
gh repo list <org-name> --source --limit 1000 --json nameWithOwner -q '.[].nameWithOwner' |
  xargs -P 5 -I{} gh repo clone {} 2>&1 | tee clone.log

# 2. 克隆特定语言仓库
gh repo list --language Go --source --json nameWithOwner -q '.[].nameWithOwner' |
  xargs -I{} gh repo clone {}

# 3. 并行克隆（提速）
gh repo list <org-name> --json nameWithOwner -q '.[].nameWithOwner' |
  parallel -j 5 gh repo clone {}

# 4. 克隆并按组织结构分类
gh repo list --json nameWithOwner,owner -q '.[] | "\(.owner.login)/\(.nameWithOwner)"' |
  while IFS='/' read org repo; do
    mkdir -p "$org" && gh repo clone "$repo" "$org/$(basename $repo)"
  done

# 克隆包含所有分支
gh repo clone <owner>/<repo> && cd <repo> && git fetch --all
```

### 快速创建仓库

```bash
# 交互式创建（推荐新手）
gh repo create

# 命令式创建（适合自动化）
gh repo create <name> --public --description "描述"
gh repo create <name> --private

# 完整初始化仓库
gh repo create my-project \
  --public \
  --description "My awesome project" \
  --homepage "https://example.com" \
  --add-readme \
  --gitignore Node \
  --license MIT

# 从当前目录创建并推送
gh repo create my-repo --source=. --remote=origin --push --public

# 使用模板创建（最佳实践）
gh repo create my-app --template vercel/next.js --public --clone
gh repo create api-service --template golang-standards/project-layout --private

# 创建组织仓库
gh repo create <org-name>/<repo-name> --public

# 创建后自动打开浏览器
gh repo create my-repo --public && gh repo view --web
```

### 查看仓库信息

```bash
# 查看当前仓库
gh repo view

# 查看指定仓库
gh repo view <owner>/<repo>

# 查看详细信息（JSON）
gh repo view --json name,description,url,stargazerCount,forkCount,createdAt

# 在浏览器中打开
gh repo view --web
```

### Fork 工作流管理

```bash
# Fork 并克隆到本地（最常用）
gh repo fork <owner>/<repo> --clone=true

# 仅 Fork 不克隆
gh repo fork <owner>/<repo> --clone=false

# Fork 并设置上游远程
gh repo fork <owner>/<repo> --clone --remote --remote-name upstream

# 同步 Fork（从上游拉取更新）
gh repo sync                           # 当前 fork
gh repo sync <owner>/<repo>            # 指定 fork
gh repo sync --branch main             # 同步指定分支
gh repo sync --force                   # 强制同步（覆盖本地更改）

# 批量同步所有 fork
gh repo list --fork --json nameWithOwner -q '.[].nameWithOwner' |
  xargs -I{} sh -c 'echo "Syncing {}" && gh repo sync {}'

# 查看 fork 状态（是否落后）
gh api repos/<owner>/<repo> --jq '.parent.full_name, .pushed_at'
```

### 仓库设置与管理

```bash
# 查看仓库详情
gh repo view                                    # 当前仓库
gh repo view <owner>/<repo>                     # 指定仓库
gh repo view --web                              # 浏览器打开
gh repo view --json name,description,stars,forks,isPrivate

# 编辑仓库信息
gh repo edit --description "新描述"
gh repo edit --homepage "https://example.com"
gh repo edit --add-topic "go,cli,tool"
gh repo edit --remove-topic "old-topic"

# 功能开关
gh repo edit --enable-issues=true
gh repo edit --enable-wiki=false
gh repo edit --enable-projects=true
gh repo edit --enable-discussions=true

# 分支管理
gh repo edit --default-branch main
gh repo edit --delete-branch-on-merge=true     # PR 合并后自动删除分支

# 可见性管理
gh repo edit --visibility public
gh repo edit --visibility private

# 重命名仓库
gh repo rename <new-name>

# 归档仓库（只读模式）
gh repo archive <owner>/<repo> --yes

# 删除仓库（谨慎！）
gh repo delete <owner>/<repo> --yes
```

### 仓库协作者管理

```bash
# 查看仓库 Deploy Keys
gh api repos/<owner>/<repo>/keys

# 添加协作者（需要通过 API）
gh api repos/<owner>/<repo>/collaborators/<username> -X PUT

# 查看协作者列表
gh api repos/<owner>/<repo>/collaborators
```

### 批量仓库管理

```bash
# 1. 批量更新本地仓库
find . -maxdepth 1 -type d -name ".git" -prune -o -type d -print | while read dir; do
  if [ -d "$dir/.git" ]; then
    echo "Updating $dir"
    git -C "$dir" pull --rebase --autostash
  fi
done

# 2. 批量查看仓库状态
gh repo list --limit 100 --json nameWithOwner,stargazerCount,updatedAt,isPrivate |
  jq -r '.[] | "\(.nameWithOwner) | \(if .isPrivate then "Private" else "Public" end) | Stars: \(.stargazerCount) | \(.updatedAt[:10])"'

# 3. 批量添加 Topic
gh repo list --source --json nameWithOwner -q '.[].nameWithOwner' |
  xargs -I{} gh repo edit {} --add-topic "go,cli"

# 4. 批量归档旧仓库（超2年未更新）
CUTOFF=$(date -d '2 years ago' +%Y-%m-%d 2>/dev/null || date -v-2y +%Y-%m-%d)
gh repo list --json nameWithOwner,updatedAt -q ".[] | select(.updatedAt < \"$CUTOFF\") | .nameWithOwner" |
  while read repo; do
    echo "Archiving: $repo"
    gh repo archive "$repo" --yes
  done

# 5. 批量启用 Discussions
gh repo list <org-name> --json nameWithOwner -q '.[].nameWithOwner' |
  xargs -I{} gh repo edit {} --enable-discussions=true

# 6. 批量查看仓库大小
gh repo list --json nameWithOwner -q '.[].nameWithOwner' |
  xargs -I{} sh -c 'echo "{}: $(gh api repos/{} --jq .size) KB"'

# 7. 导出仓库报告（CSV格式）
echo "Name,Stars,Forks,Language,Updated" > repos_report.csv
gh repo list --json nameWithOwner,stargazerCount,forkCount,primaryLanguage,updatedAt -q \
  '.[] | "\(.nameWithOwner),\(.stargazerCount),\(.forkCount),\(.primaryLanguage.name // "N/A"),\(.updatedAt[:10])"' \
  >> repos_report.csv
```

---

## Issue 管理

### 创建与管理 Issue

```bash
# 交互式创建
gh issue create

# 快速创建
gh issue create --title "Bug: Login失败" --body "描述问题..."

# 完整创建
gh issue create \
  --title "Feature Request" \
  --body "详细描述" \
  --label "enhancement,help wanted" \
  --assignee @me \
  --milestone "v2.0" \
  --project "Roadmap"

# 从模板创建
gh issue create --template bug_report.md

# 创建并在浏览器中编辑
gh issue create --web
```

### Issue 查询

```bash
# 基础查询
gh issue list                           # 打开的 Issue
gh issue list --state all               # 所有状态
gh issue list --state closed            # 已关闭

# 筛选
gh issue list --assignee @me            # 分配给我的
gh issue list --author @me              # 我创建的
gh issue list --mention @me             # 提到我的
gh issue list --label bug               # 特定标签
gh issue list --milestone "v1.0"        # 特定里程碑

# 搜索
gh issue list --search "error in:title"
gh issue list --search "is:open label:bug created:>2024-01-01"

# 限制和排序
gh issue list --limit 50
gh issue list --json number,title,author,createdAt
```

### Issue 操作

```bash
# 查看详情
gh issue view 123
gh issue view 123 --web
gh issue view 123 --comments

# 关闭 Issue
gh issue close 123
gh issue close 123 --comment "已修复" --reason "completed"

# 重新打开
gh issue reopen 123

# 编辑 Issue
gh issue edit 123 --title "新标题"
gh issue edit 123 --body "新内容"
gh issue edit 123 --add-label "bug,priority-high"
gh issue edit 123 --remove-label "question"
gh issue edit 123 --add-assignee user1
gh issue edit 123 --milestone "v2.0"

# 评论 Issue
gh issue comment 123 --body "感谢报告！"

# 批量关闭 stale issues
gh issue list --label "stale" --json number -q '.[].number' |\n  xargs -I{} gh issue close {} --comment "自动关闭过期 Issue"
```

---

## GitHub Actions

### Workflow 运行管理

```bash
# 查看运行历史
gh run list                             # 最近的运行
gh run list --workflow "CI"             # 特定 workflow
gh run list --branch main               # 特定分支
gh run list --event push                # 特定触发事件
gh run list --status failure            # 失败的运行
gh run list --status success            # 成功的运行

# 查看运行详情
gh run view <run-id>
gh run view <run-id> --log              # 查看日志
gh run view <run-id> --log-failed       # 仅失败的日志
gh run view <run-id> --web              # 浏览器查看

# 实时监控
gh run watch <run-id>
gh run watch <run-id> --exit-status     # 等待完成并返回状态码
```

### Workflow 控制

```bash
# 列出所有 Workflow
gh workflow list

# 查看 Workflow 详情
gh workflow view "CI"
gh workflow view "CI" --web

# 手动触发
gh workflow run "Deploy"
gh workflow run "Deploy" --ref main
gh workflow run "Build" -f environment=production -f debug=true

# 启用/禁用
gh workflow enable "CI"
gh workflow disable "Old Workflow"

# 重新运行
gh run rerun <run-id>                   # 重新运行所有作业
gh run rerun <run-id> --failed          # 仅重新运行失败的作业

# 取消运行
gh run cancel <run-id>

# 批量取消运行中的 workflow
gh run list --status in_progress --json databaseId -q '.[].databaseId' |\n  xargs -I{} gh run cancel {}
```

### 批量清理 Actions

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

## Pull Request 工作流

### 创建 PR 的最佳实践

```bash
# 快速创建 PR（自动填充标题和描述）
gh pr create --fill

# 完整创建 PR
gh pr create \
  --title "feat: Add new feature" \
  --body "Detailed description" \
  --base main \
  --head feature-branch \
  --label "enhancement" \
  --assignee @me \
  --reviewer username1,username2

# 创建草稿 PR
gh pr create --draft --title "WIP: Feature in progress"

# 从 Issue 创建 PR
gh pr create --title "Fix #123" --body "Closes #123"

# 使用模板创建
gh pr create --template bug_fix.md

# 创建并在浏览器中打开
gh pr create --web
```

### PR 查询与筛选

```bash
# 基础查询
gh pr list                              # 所有打开的 PR
gh pr list --state all                  # 包含已关闭
gh pr list --state merged               # 仅已合并

# 高级筛选
gh pr list --author @me                 # 我创建的
gh pr list --assignee @me               # 分配给我的
gh pr list --reviewer @me               # 我需要审查的
gh pr list --label bug,urgent           # 特定标签
gh pr list --base main                  # 目标分支
gh pr list --head feature/*             # 源分支模式

# 搜索 PR
gh pr list --search "is:pr is:open author:@me"
gh pr list --search "review:required"

# 格式化输出
gh pr list --json number,title,author,createdAt,reviews |\n  jq -r '.[] | "#\(.number) \(.title) by \(.author.login)"'
```

### PR 审查流程

```bash
# 检出 PR 到本地
gh pr checkout 123
gh pr checkout https://github.com/owner/repo/pull/123

# 查看 PR 详情
gh pr view 123
gh pr view 123 --web
gh pr view 123 --json title,body,reviews,labels

# 查看变更
gh pr diff 123
gh pr diff 123 --patch > pr-123.patch

# 查看状态检查
gh pr checks 123
gh pr checks 123 --watch              # 实时监控

# 审查 PR
gh pr review 123 --approve
gh pr review 123 --approve --body "LGTM!"
gh pr review 123 --request-changes --body "需要修改..."
gh pr review 123 --comment --body "建议..."

# 批量审查通过（特定作者的 PR）
gh pr list --author username --json number -q '.[].number' |\n  xargs -I{} gh pr review {} --approve --body "Auto-approved"
```

### PR 合并策略

```bash
# 合并 PR (默认 merge commit)
gh pr merge 123

# Squash 合并（推荐）
gh pr merge 123 --squash --delete-branch

# Rebase 合并
gh pr merge 123 --rebase

# 自动合并（等待检查通过）
gh pr merge 123 --auto --squash

# 合并并添加消息
gh pr merge 123 --squash --subject "feat: New feature" --body "Detailed changelog"

# 批量合并已批准的 PR
gh pr list --search "review:approved" --json number -q '.[].number' |\n  xargs -I{} gh pr merge {} --squash --delete-branch
```

### PR 状态管理

```bash
# 标记草稿为就绪
gh pr ready 123

# 将 PR 转为草稿
gh pr ready 123 --undo

# 关闭 PR
gh pr close 123
gh pr close 123 --comment "不再需要"

# 重新打开 PR
gh pr reopen 123

# 添加标签
gh pr edit 123 --add-label "bug,urgent"
gh pr edit 123 --remove-label "wip"

# 修改分配
gh pr edit 123 --add-assignee user1,user2
gh pr edit 123 --add-reviewer user3

# 修改里程碑
gh pr edit 123 --milestone "v1.0"
```

### PR 协作技巧

```bash
# 查看我的 PR 状态
gh pr status

# 评论 PR
gh pr comment 123 --body "Good work!"

# 查看 PR 评论
gh pr view 123 --comments

# 在 PR 中运行命令
gh pr checkout 123 && npm test && gh pr comment 123 --body "Tests passed"

# PR 工作流自动化
alias pr-ready='gh pr create --fill && gh pr ready && gh pr view --web'
```

---

## Issue 管理

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
gh alias set co 'pr checkout'
gh alias set issues 'issue list'
gh alias set prs 'pr list'
gh alias set ps 'pr status'
gh alias set rv 'run view'

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

## 进阶操作

### 使用 GitHub API 进行高级查询

```bash
# 使用 gh api 直接调用 GitHub REST API
gh api /user

# 获取仓库的详细信息
gh api repos/<owner>/<repo>

# 获取最近的提交
gh api repos/<owner>/<repo>/commits

# 分页获取数据
gh api --paginate repos/<owner>/<repo>/issues

# POST 请求创建 Issue
gh api repos/<owner>/<repo>/issues -f title="Bug Report" -f body="Description"

# PATCH 请求更新 Issue
gh api repos/<owner>/<repo>/issues/1 -X PATCH -f state="closed"
```

### 使用 GraphQL 查询

```bash
# 执行 GraphQL 查询
gh api graphql -f query='
  query {
    viewer {
      login
      name
      repositories(first: 5) {
        nodes {
          name
          stargazerCount
        }
      }
    }
  }
'

# 查询 PR 的详细信息
gh api graphql -f query='
  query($owner: String!, $repo: String!, $number: Int!) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        title
        state
        commits(last: 1) {
          nodes {
            commit {
              statusCheckRollup {
                state
              }
            }
          }
        }
      }
    }
  }
' -f owner='<owner>' -f repo='<repo>' -F number=1
```

### Gist 管理

```bash
# 创建 Gist
gh gist create file.txt

# 创建私有 Gist
gh gist create file.txt --private

# 创建多文件 Gist
gh gist create file1.txt file2.txt -d "My description"

# 列出 Gist
gh gist list

# 查看 Gist
gh gist view <gist-id>

# 编辑 Gist
gh gist edit <gist-id>

# 克隆 Gist
gh gist clone <gist-id>

# 删除 Gist
gh gist delete <gist-id>
```

### Release 管理

```bash
# 列出所有 Release
gh release list

# 查看最新 Release
gh release view

# 查看指定 Release
gh release view v1.0.0

# 创建 Release
gh release create v1.0.0 --title "Version 1.0.0" --notes "Release notes"

# 创建 Release 并上传文件
gh release create v1.0.0 dist/*.zip --title "v1.0.0" --notes "Binary releases"

# 上传文件到现有 Release
gh release upload v1.0.0 dist/*.zip

# 删除 Release
gh release delete v1.0.0

# 下载 Release 资源
gh release download v1.0.0
gh release download v1.0.0 -p "*.zip"  # 指定模式
```

### Workflow 高级操作

```bash
# 列出仓库的所有 Workflow
gh workflow list

# 查看 Workflow 详情
gh workflow view <workflow-name>

# 启用/禁用 Workflow
gh workflow enable <workflow-name>
gh workflow disable <workflow-name>

# 手动触发 Workflow
gh workflow run <workflow-name>

# 传递输入参数触发 Workflow
gh workflow run <workflow-name> -f param1=value1 -f param2=value2

# 在指定分支触发
gh workflow run <workflow-name> --ref develop
```

### Secret 和变量管理

```bash
# 列出仓库的 Secrets
gh secret list

# 设置 Secret
gh secret set SECRET_NAME
# 或从文件读取
gh secret set SECRET_NAME < secret.txt

# 删除 Secret
gh secret delete SECRET_NAME

# 列出环境变量
gh variable list

# 设置环境变量
gh variable set VAR_NAME -b "value"

# 删除环境变量
gh variable delete VAR_NAME

# 为组织设置 Secret（需要权限）
gh secret set ORG_SECRET --org <org-name>
```

### 批量 Actions 管理

```bash
# 批量检查仓库的 Actions 状态
gh repo list --limit 100 --json nameWithOwner -q '.[].nameWithOwner' | while read repo; do
  echo "=== $repo ==="
  gh run list --repo "$repo" --limit 5 --json status,conclusion,workflowName -q '.[] | "\(.workflowName): \(.status) - \(.conclusion)"'
done

# 批量启用/禁用 Workflow
gh repo list <org-name> --json nameWithOwner -q '.[].nameWithOwner' | while read repo; do
  echo ">>> Processing $repo"
  gh workflow disable <workflow-name> --repo "$repo" 2>/dev/null || echo "Workflow not found"
done
```

### 高级 PR 工作流

```bash
# 创建草稿 PR
gh pr create --draft --title "WIP: Feature X" --body "Work in progress"

# 将草稿标记为准备好审查
gh pr ready <pr-number>

# 批量审查通过 PR
gh pr list --json number,author -q '.[] | select(.author.login == "username") | .number' | xargs -I{} gh pr review {} --approve

# 自动合并 PR（启用自动合并）
gh pr merge <pr-number> --auto --squash

# 检出远程 PR 并创建本地分支
gh pr checkout <pr-number> && git checkout -b pr-<pr-number>

# 查看 PR 的状态检查
gh pr checks <pr-number>

# 查看 PR 的变更文件
gh pr diff <pr-number>

# 批量关闭过时的 PR
gh pr list --state open --json number,updatedAt -q '.[] | select(.updatedAt < "2024-01-01") | .number' | xargs -I{} gh pr close {}
```

### 监控和通知

```bash
# 查看通知
gh api notifications

# 标记所有通知为已读
gh api notifications -X PUT

# 监控 PR 状态变化
watch -n 60 'gh pr status'

# 监控特定 Run 的状态
watch -n 10 'gh run view <run-id> --log-failed'

# 获取未读通知数量
gh api notifications | jq '. | length'
```

### Extension 扩展

```bash
# 搜索扩展
gh ext search <keyword>

# 安装扩展
gh ext install <owner>/<repo>

# 常用扩展推荐
gh ext install dlvhdr/gh-dash         # 交互式仪表板
gh ext install vilmibm/gh-screensaver # 终端屏保
gh ext install mislav/gh-branch       # 分支管理增强
gh ext install k1LoW/gh-grep          # 增强的搜索功能

# 列出已安装的扩展
gh ext list

# 升级扩展
gh ext upgrade <extension>
gh ext upgrade --all

# 删除扩展
gh ext remove <extension>
```

### 环境变量和配置

```bash
# 使用环境变量设置 Token
export GH_TOKEN="ghp_xxxxxxxxxxxx"

# 设置企业版 GitHub
export GH_HOST="github.company.com"

# 禁用颜色输出
export NO_COLOR=1

# 设置默认仓库（避免每次输入）
export GH_REPO="owner/repo"

# 在命令中使用环境变量
gh issue create --title "Bug" --body "Description"  # 使用 GH_REPO

# 配置文件位置
# Windows: %APPDATA%\GitHub CLI\config.yml
# Linux/macOS: ~/.config/gh/config.yml
```

### 脚本自动化示例

```bash
# 自动创建每周进度报告
#!/bin/bash
REPORT="weekly-report-$(date +%Y%m%d).md"
echo "# Weekly Report - $(date +%Y-%m-%d)" > $REPORT
echo "" >> $REPORT
echo "## Merged PRs" >> $REPORT
gh pr list --state merged --limit 20 --json title,number,closedAt -q '.[] | "- #\(.number): \(.title) (closed: \(.closedAt))"' >> $REPORT
gh gist create $REPORT --public

# 监控失败的 Workflow 并发送通知
#!/bin/bash
FAILURES=$(gh run list --status failure --limit 5 --json databaseId,workflowName,conclusion -q '.[] | "\(.workflowName) - \(.conclusion)"')
if [ -n "$FAILURES" ]; then
  echo "Found failures:"
  echo "$FAILURES"
  # 这里可以集成发送邮件或其他通知
fi

# 自动清理超过 30 天的 Workflow 运行记录
#!/bin/bash
CUTOFF_DATE=$(date -d '30 days ago' +%Y-%m-%d 2>/dev/null || date -v-30d +%Y-%m-%d)
gh run list --limit 500 --json databaseId,createdAt -q ".[] | select(.createdAt < \"$CUTOFF_DATE\") | .databaseId" | xargs -I{} gh run delete {}
```

### 性能优化和最佳实践

```bash
# 使用 --json 和 --jq 内置过滤（比管道到 jq 更快）
gh pr list --json number,title,state --jq '.[] | select(.state == "OPEN")'
gh api repos/<owner>/<repo>/issues --jq '.[] | select(.state == "open")'

# 限制结果数量避免 API 限流
gh run list --limit 50                  # 避免默认1000
gh repo list --limit 100 --source

# 使用缓存避免重复请求
REPOS=$(gh repo list --json nameWithOwner -q '.[].nameWithOwner')
echo "$REPOS" | while read repo; do
  # 处理仓库
done

# 并行执行加速批量操作
gh repo list --json nameWithOwner -q '.[].nameWithOwner' | xargs -P 5 -I{} gh repo view {}

# 使用 --paginate 时注意 API 限额
gh api --paginate repos/<owner>/<repo>/issues | jq -s 'add'
```

---

## 扩展生态

### 推荐扩展

```bash
# 交互式仪表板（强烈推荐）
gh ext install dlvhdr/gh-dash
gh dash  # 启动交互式界面

# 增强搜索
gh ext install k1LoW/gh-grep
gh grep "function" --repo <owner>/<repo>

# 分支管理增强
gh ext install mislav/gh-branch
gh branch --list --all

# 代码统计
gh ext install kawamataryo/gh-graph
gh graph  # 显示贡献图

# PR 模板
gh ext install chelnak/gh-changelog
gh changelog generate

# 扩展管理
gh ext list                             # 查看已安装
gh ext upgrade --all                    # 升级所有
gh ext search dashboard                 # 搜索扩展
```

---

## 最佳实践

### 安全建议

```bash
# 使用 SSH 而非 HTTPS
gh config set git_protocol ssh

# Token 安全
# 1. 使用环境变量
export GH_TOKEN="ghp_xxxx"

# 2. 使用 gh auth login 而非明文 token
gh auth login

# 3. 定期刷新 Token
gh auth refresh -h github.com -s repo,workflow

# 4. 多账号管理
gh auth login --hostname github.com
gh auth switch --hostname github.com

# Secret 管理最佳实践
# 使用组织级 Secret
gh secret set TOKEN --org <org> --visibility selected --repos "repo1,repo2"

# 从密钥管理器读取
gh secret set DB_PASSWORD < <(pass show db/password)
```

### 团队协作技巧

```bash
# 1. 统一别名配置（团队共享）
cat > .gh-aliases << 'EOF'
co: pr checkout
pv: pr view --web
ic: issue create --label "team-review"
EOF

# 团队成员执行
while read line; do
  alias=$(echo "$line" | cut -d: -f1)
  cmd=$(echo "$line" | cut -d: -f2-)
  gh alias set "$alias" "$cmd"
done < .gh-aliases

# 2. PR 模板自动化
gh pr create --template .github/PULL_REQUEST_TEMPLATE/feature.md

# 3. 代码审查规范
gh pr review $PR --comment --body "$(cat review-checklist.md)"

# 4. 自动化工作流
alias daily-standup='gh issue list --assignee @me && gh pr list --author @me'
```

### CI/CD 集成

```bash
# 在 CI 中使用 gh
# .github/workflows/release.yml

# 获取最新标签
LATEST_TAG=$(gh release list --limit 1 --json tagName -q '.[0].tagName')

# 创建 Release
gh release create v1.0.0 \
  --title "Release v1.0.0" \
  --notes "$(gh api repos/:owner/:repo/releases/generate-notes -f tag_name=v1.0.0 -q .body)" \
  dist/*.zip

# 自动合并 PR
gh pr merge $PR_NUMBER --auto --squash --delete-branch

# 触发 Workflow
gh workflow run deploy --ref main -f environment=production
```

---

## 实战场景

### 场景 1: 组织仓库大扫除

```bash
#!/bin/bash
# repo-cleanup.sh - 清理组织中的陈旧仓库

ORG="your-org"
CUTOFF_DATE="2023-01-01"

echo "开始分析 $ORG 的仓库..."

# 1. 查找陈旧仓库
gh repo list $ORG --limit 1000 --json nameWithOwner,updatedAt,stargazerCount,isArchived \
  --jq ".[] | select(.updatedAt < \"$CUTOFF_DATE\" and .isArchived == false and .stargazerCount < 5)" \
  > stale-repos.json

# 2. 生成报告
echo "发现 $(jq length stale-repos.json) 个陈旧仓库"
jq -r '.[] | "\(.nameWithOwner) - 最后更新: \(.updatedAt[:10]) - Stars: \(.stargazerCount)"' stale-repos.json

# 3. 批量归档（需确认）
read -p "是否归档这些仓库？(y/N): " confirm
if [ "$confirm" = "y" ]; then
  jq -r '.[].nameWithOwner' stale-repos.json | while read repo; do
    echo "归档 $repo"
    gh repo archive "$repo" --yes
  done
fi
```

### 场景 2: PR 自动化审查

```bash
#!/bin/bash
# auto-review.sh - 自动审查符合条件的 PR

# 审查checklist
check_pr() {
  local pr=$1
  local repo=$2

  # 获取 PR 信息
  info=$(gh pr view $pr --repo $repo --json title,additions,deletions,changedFiles)

  additions=$(echo "$info" | jq '.additions')
  deletions=$(echo "$info" | jq '.deletions')
  files=$(echo "$info" | jq '.changedFiles')

  # 自动审查规则
  if [ $additions -lt 100 ] && [ $deletions -lt 50 ] && [ $files -lt 5 ]; then
    echo "PR $pr 符合快速审查条件"
    gh pr review $pr --repo $repo --approve --body "自动审查通过 (小型变更)"
    return 0
  fi

  echo "PR $pr 需要人工审查"
  return 1
}

# 处理所有待审查的 PR
gh search prs --review-requested=@me --json number,repository --jq '.[] | "\(.repository.nameWithOwner) \(.number)"' |
  while read repo pr; do
    check_pr $pr $repo
  done
```

### 场景 3: 多仓库发布管理

```bash
#!/bin/bash
# multi-repo-release.sh - 同时发布多个仓库

VERSION="v1.2.0"
REPOS=("org/repo1" "org/repo2" "org/repo3")

for repo in "${REPOS[@]}"; do
  echo "发布 $repo $VERSION"

  # 创建 tag
  gh api repos/$repo/git/refs -f ref="refs/tags/$VERSION" -f sha="$(gh api repos/$repo/git/refs/heads/main --jq .object.sha)"

  # 创建 release
  gh release create $VERSION --repo $repo \
    --title "Release $VERSION" \
    --notes "Multi-repo synchronized release" \
    --generate-notes

  # 触发部署 workflow
  gh workflow run deploy --repo $repo --ref $VERSION
done

echo "所有仓库发布完成"
```

### 场景 4: Issue 批量处理

```bash
#!/bin/bash
# issue-triage.sh - 批量分类和处理 Issue

# 自动标记陈旧 Issue
gh issue list --limit 100 --json number,updatedAt,labels --jq \
  '.[] | select(.updatedAt < "'$(date -d '90 days ago' +%Y-%m-%d)'") | select([.labels[].name] | index("stale") | not) | .number' |
  while read issue; do
    echo "标记 Issue #$issue 为 stale"
    gh issue edit $issue --add-label "stale"
    gh issue comment $issue --body "此 Issue 90 天未更新，标记为 stale。如仍需处理请回复。"
  done

# 关闭超过 120 天的 stale issues
gh issue list --label "stale" --json number,updatedAt --jq \
  '.[] | select(.updatedAt < "'$(date -d '120 days ago' +%Y-%m-%d)'") | .number' |
  while read issue; do
    echo "关闭 Issue #$issue"
    gh issue close $issue --comment "由于长时间无活动，自动关闭。" --reason "not_planned"
  done
```

---

## 常见问题

### 认证问题

```bash
# Token 过期
gh auth refresh -h github.com -s repo,workflow,admin:org

# 权限不足
gh auth status  # 查看当前权限
gh auth login --scopes "repo,workflow,admin:org"

# 企业版配置
gh auth login --hostname github.company.com
```

### 性能问题

```bash
# API 限流
gh api rate_limit  # 查看剩余配额

# 减少 API 调用
gh repo list --limit 50  # 限制数量
gh api --paginate --jq  # 使用内置 jq 过滤

# 并行处理慢
xargs -P 3  # 减少并行数
```

### 常见错误

```bash
# "GraphQL: Resource not accessible by integration"
# 需要更多权限
gh auth refresh -s admin:org

# "Could not resolve to a Repository"
# 仓库不存在或无权限
gh repo view <owner>/<repo>  # 验证访问

# "refusing to allow an OAuth App to create or update workflow"
# Token 类型不对，需要 Personal Access Token
gh auth login --web
```

---

## 速查表

### 常用命令速查

```bash
# 仓库
gh repo clone <owner>/<repo>           # 克隆
gh repo create <name> --public         # 创建
gh repo fork <owner>/<repo> --clone    # Fork
gh repo sync                           # 同步 Fork
gh repo view --web                     # 浏览器打开

# PR
gh pr create --fill                    # 创建
gh pr list --author @me                # 我的 PR
gh pr checkout 123                     # 检出
gh pr review 123 --approve             # 审查
gh pr merge 123 --squash               # 合并

# Issue
gh issue create                        # 创建
gh issue list --assignee @me           # 我的 Issue
gh issue close 123                     # 关闭

# Actions
gh run list --status failure           # 失败的运行
gh run watch <id>                      # 监控
gh workflow run <name>                 # 触发

# API
gh api repos/<owner>/<repo>            # REST API
gh api graphql -f query='...'          # GraphQL
```

### JSON 查询常用模式

```bash
# 提取字段
-q '.[].fieldName'

# 过滤
-q '.[] | select(.status == "failure")'

# 映射
-q '.[] | {id: .databaseId, name: .name}'

# 数组切片
-q '.[0:10]'  # 前 10 个
-q '.[10:]'   # 跳过前 10 个
```

---

## 参考资料

### 官方文档
- [GitHub CLI 官方文档](https://cli.github.com/manual/)
- [GitHub CLI 仓库](https://github.com/cli/cli)
- [GitHub REST API](https://docs.github.com/rest)
- [GitHub GraphQL API](https://docs.github.com/graphql)
- [GitHub Actions 文档](https://docs.github.com/actions)

### 社区资源
- [gh-cli Discussions](https://github.com/cli/cli/discussions)
- [Awesome gh Extensions](https://github.com/topics/gh-extension)

---

## 更新日志

- **2025-12-23**:
  - 新增批量自动化章节
  - 添加实战场景和最佳实践
  - 增强 PR 和 Issue 工作流
  - 补充 API 高级用法
  - 添加常见问题和速查表
  - 初始版本
