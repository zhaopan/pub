# npm

## 切换源

### 方案1: 使用 nrm

```bash
# 安装
npm install -g nrm

# 列出可用源
nrm ls

# 切换源
nrm use taobao
```

### 方案2: 全局配置

```bash
# 设置淘宝源
npm config set registry https://registry.npm.taobao.org

# 验证
npm config get registry
# https://registry.npm.taobao.org/

# 测试连接
npm info underscore
```

### 方案3: 命令行指定

```bash
npm --registry https://registry.npm.taobao.org install [name]
```

### 方案4: 修改 ~/.npmrc

```ini
registry = https://registry.npm.taobao.org
```

### 方案5: 使用 cnpm

```bash
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm install [name]
```

## 初始化与安装

```bash
# 创建 package.json
npm init
npm init -y                     # 使用默认配置

# 安装依赖
npm install <package>          # 安装并保存到 dependencies
npm install -D <package>        # 安装并保存到 devDependencies
npm install -g <package>        # 全局安装
npm install <package>@latest    # 安装最新版本
npm install <package>@1.0.0     # 安装指定版本
npm install <package>@^1.0.0    # 匹配 1.x.x 范围

# 卸载
npm uninstall <package>
npm uninstall -g <package>

# 更新
npm update <package>
npm update -g <package>
npm update                      # 更新所有依赖
```

## 查看与搜索

```bash
# 查看已安装的包
npm list                        # 当前项目
npm list -g                     # 全局
npm list --depth=0              # 只显示一级依赖

# 查看包信息
npm info <package>
npm view <package> version     # 查看最新版本
npm view <package> versions    # 查看所有版本

# 搜索
npm search <keyword>
```

## package.json scripts

```bash
# 在 package.json 中定义
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "test": "vitest",
    "lint": "eslint ."
  }
}

# 运行脚本
npm run dev
npm run build
npm test
```

## workspaces

```bash
# 在根 package.json 中配置
{
  "workspaces": [
    "packages/*"
  ]
}

# 在工作区中运行命令
npm install                      # 在根目录安装所有工作区的依赖
npm install <package> -w packages/ui   # 在指定工作区安装
```

## 缓存管理

```bash
# 清除缓存
npm cache clean --force

# 查看缓存位置
npm cache ls

# 离线安装
npm install --offline
```

## 发布包

```bash
# 登录
npm login

# 发布
npm publish                      # 发布到 npmjs.org
npm publish --access public      # 发布公开作用域包

# 更新版本
npm version patch                # 1.0.0 -> 1.0.1
npm version minor                # 1.0.0 -> 1.1.0
npm version major                # 1.0.0 -> 2.0.0
```

## 其他常用命令

```bash
npm outdated                     # 检查过时的依赖
npm audit                        # 安全审计
npm audit fix                    # 自动修复安全问题
npm ci                           # 全新安装 (基于 package-lock.json)
npm ls <package>                 # 查看包的依赖树
npm explain <package>            # 查看包为什么被安装
npm deprecate <package>@<version> "<message>"  # 弃用警告

# 查看全局模块位置
npm root -g
npm bin                          # 查看当前项目的 node_modules/.bin
```

## nvm

### Linux/macOS

```bash
# 安装
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc

# 常用命令
nvm install 22                   # 安装 Node 22
nvm use 22                       # 使用 Node 22
nvm alias default 22             # 设置默认版本
nvm ls | grep -v "N/A"           # 列出已安装版本
nvm cache clear                  # 清除缓存

# 查看版本
node -v
npm -v
```

### Windows

使用 [nvm-windows](https://github.com/coreybutler/nvm-windows) 或 [fnm](https://github.com/Schniz/fnm):

```bash
# 使用 fnm (跨平台)
winget install Schniz.fnm

# 或使用 nvm-windows
# 下载: https://github.com/coreybutler/nvm-windows/releases
```

## pnpm (推荐替代方案)

```bash
# 安装
npm install -g pnpm

# 常用命令 (与 npm 用法相同)
pnpm install
pnpm add <package>
pnpm remove <package>
pnpm update

# 特点: 速度快、节省磁盘空间
```

## yarn

```bash
# 安装
npm install -g yarn

# 常用命令
yarn install
yarn add <package>
yarn remove <package>
yarn upgrade
yarn build

# 特点: 确定性安装、工作区支持
```
