#!/bin/bash

# user.name
git config --global user.name "name"

# user.email
git config --global user.email "email address"

# 设置大小写敏感 windows不区分大小写的解决办法
git config --global core.ignorecase false

##
## 关闭SSL
##
#git config --global http.sslVerify false

# store credential
git config --global credential.helper store

# push 超限
git config --global http.postBuffer 524288000

# 自动变基
git config --global pull.rebase true
git config --global rebase.autoStash true

# 保持仓库中以 CRLF/LF 换行
###
###
# macOS/linux
git config --global core.autocrlf input

# windwos
git config --global core.autocrlf true
###
###

# git中文路径名称乱码
git config --global gui.encoding utf-8
git config --global core.quotepath false

# 让git mergetool不再生成烦人的备份文件 *.orig 
git config --global mergetool.keepBackup false

# 不修改文件模式(文件mode变化不提交到仓库)
git config --add --global core.filemode false

# 添加 git 安全目录
git config --global --add safe.directory "*"

# 设置checkout -> ck
git config --global alias.ck checkout

# 设置status -> st
git config --global alias.st "status -sb"

# 设置branch -> br
git config --global alias.br branch

# 设置commit -> cm
git config --global alias.cm commit

# 设置commit -> cma
git config --global alias.cma "commit -am 'fix'"

# 设置status -> sw
git config --global alias.sw switch

# 设置log -> lg，并格式化输出
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# 附加最后一次提交
git config --global alias.append "commit --amend --no-edit"

# 没有任何改动的提交
git config --global alias.foo "commit -m "foo" --allow-empty"
