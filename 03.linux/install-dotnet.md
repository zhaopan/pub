# install-dotnet-sdk

install-dotnet.sh

```bash
#!/bin/sh
set -e

# 1. 定义变量
DOWNLOAD_DIR="/mnt/tools"
INSTALL_DIR="/mnt/sdk/dotnet"
SDK_VERSION="9.0.306"
SDK_URL="https://builds.dotnet.microsoft.com/dotnet/Sdk/${SDK_VERSION}/dotnet-sdk-${SDK_VERSION}-linux-x64.tar.gz"
SDK_FILENAME=$(basename "$SDK_URL")
DOWNLOAD_PATH="$DOWNLOAD_DIR/$SDK_FILENAME"

# 2. 创建目录
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$INSTALL_DIR"

# 3. 下载
echo "正在将 $SDK_FILENAME 下载到 $DOWNLOAD_DIR... "
wget -O "$DOWNLOAD_PATH" "$SDK_URL"

# 4. 解压
echo "正在将 $DOWNLOAD_DIR/$SDK_FILENAME 解压到 $INSTALL_DIR..."
tar zxf "$DOWNLOAD_DIR/$SDK_FILENAME" -C "$INSTALL_DIR"

# 5. (可选) 清理下载的压缩包
echo "清理下载文件..."
#rm "$DOWNLOAD_DIR/$SDK_FILENAME"

export DOTNET_ROOT="/mnt/sdk/dotnet"
export PATH="$PATH:$INSTALL_DIR"

# 6. test
dotnet --version
```

## install

```bash
# 授权
chmod +x install-dotnet.sh

# 执行
sh install-dotnet.sh

# 写入环境变量
echo 'export DOTNET_ROOT="/mnt/sdk/dotnet"
export PATH="$PATH:/mnt/sdk/dotnet"' >> ~/.zshrc

# 永久生效
source ~/.zshrc

# test
dotnet --version

> 9.0.306

```
