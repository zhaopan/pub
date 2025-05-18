# make

## windows install

参考阅读

- [scoop](https://scoop.sh/)

安装

- Install scoop tool

```bash
# Windows PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

- Install make

```bash
# 安装 make
scoop install make

# 验证安装
make --version
```