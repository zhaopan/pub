# git remark

## git保存密码

`vim .git/config`

```xml
[credential]

    helper = store
```

## 获取最新

```bash
git reset --hard
git pull
```bah

## 覆盖本地仓库

```bash
git fetch origin master
```

## 拉取 Git 远端分支

### 例如，我要拉取远端其他小伙伴提交的新分支 test

```bash
git fetch
git checkout -b test origin/test
```

## git commit

```bash
git commit -am 'commit remark'
git push origin master
```

## 分支推送，若远程不存在分支则在远程创建新分支

```bash
git push origin 本地分支名:远程分支名
```

## 查看用户名和邮箱地址

```bash
$git config user.name
$git config user.email
```

## 修改用户名和邮箱地址

```bash
$git config --global user.name "xxx"
$git config --global user.email "xxx@gmail.com"
```