# CentOS7安装.Net Core2.2

## 一、安装.Dotnet Core 2.2 Runtime

Linux上运行Dotnet Core程序的前提是安装Dotnet Core Runtime

.Net Core对不同的Linux版本提示了不同的方案，本文是基于CentOS7环境下安装，请根据个人环境进行选择。

* Step 1：安装Dotnet产品的必要前提

  在安装Dotnet Core前，需要注册Microsoft签名密钥并添加Microsoft产品提要，每台机器只需注册一次，执行如下命令：

```text
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
```

* Step 2：安装Dotnet Core Runtime，执行下列命令

```text
sudo yum update
sudo yum install aspnetcore-runtime-2.2
```

## 二、安装Dotnet Core SDK

如果想要在Linux做 .NET Core的开发和编译工作，那么需要安装 Dotnet Core SDK。Dotnet Core SDK中包括了Dotnet Core Runtime

* Step 1与安装Dotnet Core Runtime 的第一步是一样的
* Step 2：安装Dotnet Core SDK，执行下列命令

```text
sudo yum update
sudo yum install dotnet-sdk-2.2
```

### 检查安装情况

执行 dotnet --version 命令，如果正常显示dotne版本号，则说明安装成功。

```text
dotnet --version
```

### 更多内容详细官方链接

[https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download)
