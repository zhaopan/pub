# python

## install

```bash
# 首先配置python3环境
# 1.python源：https://www.python.org/(最好是下载高版本)
# 2.下载安装脚本启动安装，并点选添加python到PATH(环境变量)
# 3.验证：
python --version
```

## pip

```bash
# pip安装
# 1.pip安装脚本下载：https://mirrors.aliyun.com/pypi/get-pip.py
# 2.执行：
python3 get-pip.py
# 3.验证：
pip --version
```

## 修改pip源

```bash
# 参考链接
https://mirrors.tuna.tsinghua.edu.cn/help/pypi
#清华：
https://pypi.tuna.tsinghua.edu.cn/simple
#阿里云：
https://mirrors.aliyun.com/pypi/simple/

# 1>管理员启动cmd
# 2>换源
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
# 3>更新源
python -m pip install --upgrade pip
```
