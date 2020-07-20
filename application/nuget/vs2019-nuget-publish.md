# vs2019(vs2017)配置菜单发布nuget包

## 准备工作

- 下载 nuget.exe
- 设置环境变量 [系统变量]-[Pash]:nuget.exe的目录

## 1：在“工具”》“外部工具”，添加一条记录

- 标题：发布nuget
- 命令：cmd.exe
- 参数：/c del /q *.nupkg && nuget pack && nuget push *.nupkg -Apikey 你点nugetapikey -Source http://10.13.10.108:60191/nuget
- 初始目录：$(ProjectDir)

## 2：在“工具”》“自定义”，选择“命令”，

- 选择“上下文菜单”：“项目和解决方案上下文菜单|项目”
- 点击“添加命令”》在弹出的选择框中，选择左侧“工具”项，右侧选择“命令2”（因为你第一步中“发布nuget”属于命令2），确定即可。
- 修改所选内容，更名为“Nuget Push”或者“发布Nuget”，即可

## remark

```bash
# 生成
nuget pack

# 删除
nuget delete WK.UtilTest 3.0.0 -Apikey 123456 -Source http://123.207.69.117:7003/nuget
```
