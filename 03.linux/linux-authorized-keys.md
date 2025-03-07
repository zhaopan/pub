# linux-authorized-keys

## 生成SSH私钥

```bash
# 1.生成私钥

#
# linux
#
ssh-keygen -t rsa
ssh-keygen -t rsa -C "xxx@xxx.com"
ssh-keygen -t rsa -C "xxx@xxx.com" -f "github_id_rsa"
cat id_rsa.pub >> authorized_keys

#
# Windows
#
# windows端使用puttygen加载id_rsa，另存为.ppk
conection->data->auto-login，设置默认用户名
ssh->auth->加载私钥(*.ppk)

## 2.修改Linux配置
sudo vim /etc/ssh/sshd_config
PubkeyAuthentication yes
AuthorizedKeysFile ~/.ssh/authorized_keys

## 3.设置权限

# 客户端设置
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/_authorized_keys
chmod 400 ~/.ssh/*_id_rsa
# OR
chmod 755 ~
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod -R 600 ~/.ssh/*id_rsa
chmod -R 600 ~/Dropbox/.ssh/*id_rsa
chmod -R 600 ~/Dropbox/.ssh/*pem

## 4.重启ssh
systemctl restart sshd

## 5.临时添加ssh_id_rsa
## 重启后失效
ssh-agent bash
ssh-add -l
ssh-add github_id_rsa
ssh-add -l
# 直接用密钥登陆
ssh -i github_id_rsa root@remote_host

## eg: Test github ssh connection
ssh -vT git@github.com
```

## ssh key file names or locations

`~/.ssh/config`

```bash
###
### eg:
###

#
# gitlab
#
Host my-git.company.com
RSAAuthentication yes
IdentityFile ~/gitlab_id_rsa

#
# git
#
Host github.com
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/github_id_rsa
User git

#
# linux/unix
#
Host ts01
HostName 193.112.72.198
Port 22
IdentityFile ~/ts01.pem
User root
```

## windows

### UNPROTECTED PRIVATE KEY FILE

```bash
###
### 当您在Windows上使用SSH连接远程服务器时，出现
### WARNING: UNPROTECTED PRIVATE KEY FILE!

# 这通常是由于私钥文件的权限设置过于开放导致的。以下是解决该问题的步骤：

# 1.右键点击私钥文件（例如 github_id_rsa），选择“属性”
# 2.进入“安全”选项卡，点击“高级”按钮
# 3.在“高级安全设置”窗口中，更改所有者为当前用户
# 4.点击“禁用继承”按钮，然后选择“从此对象中删除所有继承的权限”
# 5.点击“添加”按钮，选择“主体”，输入当前用户名，然后选择“完全控制” (确保只有当前用户有读写权限)
```

### Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
