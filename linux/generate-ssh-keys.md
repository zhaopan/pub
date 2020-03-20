# generate-ssh-keys.md

## SSH keys
SSH key 可以让你在你的电脑和Code服务器之间建立安全的加密连接。 先执行以下语句来判断是否已经存在本地公钥：
```bash
cat ~/.ssh/id_rsa.pub
```
如果你看到一长串以 `ssh-rsa`或 `ssh-dsa`开头的字符串, 你可以跳过 `ssh-keygen`的步骤。

提示: 最好的情况是一个密码对应一个ssh key，但是那不是必须的。你完全可以跳过创建密码这个步骤。请记住设置的密码并不能被修改或获取。

你可以按如下命令来生成ssh key：
```bash
# 生成SSH.KEY
ssh-keygen -t rsa -C "xxxxx@xxxxx.com"
```

这个指令会要求你提供一个位置和文件名去存放键值对和密码，你可以点击Enter键去使用默认值。

用以下命令获取你生成的公钥：

```bash
# 输出查看
cat ~/.ssh/id_rsa.pub
```

复制这个公钥放到你的个人设置中的SSH/My SSH Keys下，请完整拷贝从`ssh-`开始直到你的用户名和主机名为止的内容。

如果打算拷贝你的公钥到你的粘贴板下，请参考你的操作系统使用以下的命令：

```bash
# Windows
clip < ~/.ssh/id_rsa.pub

# Mac
pbcopy < ~/.ssh/id_rsa.pub

# GNU/Linux (requires xclip)
xclip -sel clip < ~/.ssh/id_rsa.pub

# 测试SSH候选连接安全性
# -v显示详细信息
ssh -vT git@github.com
```

## Applications

### Eclipse

如何在Eclipse中添加ssh key: https://wiki.eclipse.org/EGit/User_Guide#Eclipse_SSH_Configuration

### Tip: Non-default OpenSSH key file names or locations

如果，不管你有什么理由，当你决定去用一个非默认的位置或文件名去存放你的ssh key。你必须配置好你的ssh客户端以找到你的ssh私钥去连接Code服务器，对于OpenSSH客户端，这个通常是在`~/.ssh/config`类似的位置配置的：

```bash
#
# Our company's internal GitLab server
#
Host my-git.company.com
RSAAuthentication yes
IdentityFile ~/my-ssh-key-directory/company-com-private-key-filename
```
