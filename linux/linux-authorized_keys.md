# linux-authorized_keys

```bash
# 1.生成私钥

`linux`
ssh-keygen -t rsa
cat id_rsa.pub >> authorized_keys

`Windows`
#windows端使用puttygen加载id_rsa，另存为.ppk
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

## 4.重启ssh
systemctl restart sshd
```