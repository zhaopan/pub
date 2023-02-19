设置npm源的几种方式
```bash
# the original source
https://registry.npmjs.org/

###
### 方案1: 使用nrm
###

# 安装
npm install -g nrm

# 列出源的候选项
nrm ls

# 使用淘宝源
nrm use taobao

###
### 方案2: 改变全局的注册
###

# 设置成淘宝源
npm config set registry https://registry.npm.taobao.org
# 查看结果
npm config get registry
# 输出结果：
https://registry.npm.taobao.org/
# 测试一下
npm info underscore

###
### 方案:3 在命令行里指定源(个人推荐)
###
npm --registry https://registry.npm.taobao.org install [name]

###
### 方案4: 修改 ~/.npmrc
###
registry = https://registry.npm.taobao.org

###
### 方案5: 使用cnpm
###
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm install [name]
```

```bash
# 创建 package.json 文件

npm init
# 以默认配置创建 package.json 文件
npm init -y

# 全局安装
npm install -g <--save/--save-dev>  [模块名]
# 简写
npm i -g <--save/--save-dev> [模块名]

# 局部安装
npm install <--save/--save-dev> [模块名]
# 简写
npm i <--save/--save-dev> [模块名]

#说明：

# npm install 后面的 --save 与 --save-dev 可选，当该参数存在时，表示 npm 维护一份列表，记录安装过的第三方依赖，此列表内容存放于 package.json 中，分别为 dependencies 与 devDependencies，dependencies 表示项目运行时需要的依赖模块，devDependencies 表示项目开发是需要的依赖模块 。

# 查看全局模块
npm list -g
# 查看全局安装模块的一级目录
npm list -g --depth 0

# 更新模块
npm update -g [模块名]

# 卸载模块
npm uninstall -g [模块名]

# 获取当前在线仓库镜像地址
npm get registry

# 设置在线仓库地址(设置淘宝仓库镜像地址)
npm set registry https://registry.npm.taobao.org
```
