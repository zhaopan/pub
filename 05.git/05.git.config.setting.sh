# 05 | Git 配置脚本（全局设置）

# 此脚本用于初始化 Git 的全局配置，包含用户信息、别名、行为偏好等
# ⚠️ 本文件为真实配置原文，请不要删改任何字段

git config --global user.name "your-name"
git config --global user.email "your-email@example.com"
git config --global core.editor "vim"
git config --global init.defaultBranch main
git config --global merge.tool vimdiff
git config --global core.autocrlf input
git config --global color.ui auto

# alias 快捷命令设置
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.df diff
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
