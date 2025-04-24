# 🔧 Git 模块知识库

本模块系统性整理了 Git 在工程化开发中的基础命令、高级操作、分支协作、配置管理与日常高频命令，特别保留了作者自用配置（`05.git.config.setting.sh`）与高频速查文件（`foo.md`），具备高度实战性和可迁移性。

---

## 📘 模块结构总览

| 编号 | 文件名                                       | 内容简介                                |
| ---- | -------------------------------------------- | --------------------------------------- |
| 00   | [模块导语](./00-overview-git.md)             | Git 的工程价值与模块结构说明            |
| 00h  | [Hook 实战](./00.hook.md)                    | Git hook 自动化操作配置说明             |
| 01   | [基础命令实践](./01-basic-usage.md)          | clone / add / commit / push / pull      |
| 02   | [分支与合并](./02-branch-merge.md)           | branch / merge / rebase / checkout      |
| 03   | [历史与排错](./03-history-troubleshoot.md)   | reset / revert / stash / diff 等        |
| 04   | [协作与工作流](./04-workflow.md)             | Git Flow、提交规范、PR 工作流           |
| 05   | [配置与别名脚本](./05.git.config.setting.sh) | Git 全局配置与 alias 定义（⚠️ 原文保留） |
| foo  | [高频命令清单](./foo.md)                     | 个人最常用命令合集（速查用）            |

---

## 🧰 推荐使用方式

- 📖 按模块阅读，从基础到协作逐步构建 Git 思维体系
- 🔍 快速查阅：用 `foo.md` 和 alias 配置文件作为命令备忘
- 🛠️ 自定义使用：基于 `05.git.config.setting.sh` 进行个人化扩展

---

## 💡 结合工具建议

| 工具                    | 用途                 |
| ----------------------- | -------------------- |
| `tig`                   | Git 终端可视化浏览器 |
| `git log --graph`       | 图形化提交历史       |
| `husky` / `lint-staged` | Git hook 自动化      |
| GitHub / GitLab / Gitee | 托管与协作平台支持   |

---

## 📦 后续拓展建议

- 合并 `.gitignore` 管理模板
- 添加 git submodule / subtree 操作实践
- 搭建 Git Server 本地部署流程（Gitea / GitLab CE）

---

> 📁 本模块建议与 Docker / Compose / kubectl 模块并列管理，构建统一 CLI 工具知识体系。
