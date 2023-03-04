# linux-authorized-keys

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
chmod 755 ~
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/*id_rsa
chmod 600 ~/Dropbox/.ssh/*id_rsa

## 4.重启ssh
systemctl restart sshd

## 5.临时添加ssh_id_rsa
## 重启后失效
ssh-agent bash
ssh-add -l
ssh-add github_id_rsa
ssh-add -l

## eg: Test github ssh connection
ssh -vT git@github.com
```

### ssh key file names or locations

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
# linux-authorized-keys

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
chmod 755 ~
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod 600 ~/Dropbox/.ssh

## 4.重启ssh
systemctl restart sshd

## 5.临时添加ssh_id_rsa
## 重启后失效
ssh-agent bash
ssh-add -l
ssh-add github_id_rsa
ssh-add -l

## eg: Test github ssh connection
ssh -vT git@github.com
```

### ssh key file names or locations

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
