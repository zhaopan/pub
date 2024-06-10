# golang

## download

```bash
# sdk
mkdir /mnt/sdk

# go 工作区
mkdir /mnt/go

# downloand golang
weget https://go.dev/dl/go1.18.linux-amd64.tar.gz

##
## or
##

# scp golang
scp /d/download/go1.18.linux-amd64.tar.gz root@10.10.0.1:/mnt/sdk/go1.18.linux-amd64.tar.gz

# tar
cd /mnt/sdk
tar -xzvf go1.18.linux-amd64.tar.gz
```


# 设置环境变量

```bash
###
### debian eg:
###
echo "export GOROOT=/mnt/sdk/go" >>~/.bash_profile
echo "export GOPATH=/mnt/go" >>~/.bash_profile
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >>~/.bash_profile
source ~/.bash_profile

###
### osx eg:
###
echo "export GOROOT=/mnt/sdk/go" >>~/.zshrc
echo "export GOPATH=/mnt/go" >>~/.zshrc
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >>~/.zshrc
source .zshrc

# 验证安装
go version
```

## 设置环境变量
```bash
# go v1.13之后默认开启 go module
go env -w GO111MODULE=on

# 开启代理，防止下载包失败
go env -w GOPROXY=https://goproxy.cn,direct
```

## go mod

```bash
go mod init      # 初始化 go.mod
go mod tidy      # 更新依赖文件
go mod download  # 下载依赖文件
go mod vendor    # 将依赖转移至本地的vendor文件
go mod edit      # 手动修改依赖文件
go mod graph     # 打印依赖图
go mod verify    # 校验依赖
go mod help      # go mod 帮助
```
