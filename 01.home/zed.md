# zed

## windows install

参考阅读

- [zed-windows-builds](https://github.com/deevus/zed-windows-builds)
- [scoop](https://scoop.sh/)

安装

- Install scoop tool

```bash
# Windows PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

- Install zed

```bash
# Stable builds
scoop bucket add extras
scoop install extras/zed

# update
scoop update zed
```

## 配置

- 常规配置

```json
{
  "buffer_font_family": "Intel One Mono", // 编辑器字体
  "buffer_font_size": 16, // 编辑器字体大小
  "cursor_blinking": true, // 光标闪烁
  "format_on_save": "on", // 保存时自动格式化
  "hard_tabs": false, // 使用空格代替制表符
  "relative_line_numbers": true, // (可选) 相对行号
  "scrollbar": "visible",
  "show_whitespaces": "selection", // 显示空白字符
  "tab_bar": "show", // (可选) 总是显示 Tab 栏
  "tab_size": 2, // 缩进空格数
  "trim_trailing_whitespace": true, // 保存时去除行尾空格
  "ui_font_family": "Intel One Mono", // UI 字体
  "ui_font_size": 16, // UI 字体大小
  "wrap_lines": "editor_width", // 行自动换行
  "theme": {
    "mode": "system",
    "light": "One Light",
    "dark": "One Dark"
  },
  "file_scan_exclusions": [
    // 文件夹&文件排除配置
    "**/.DS_Store",
    "**/.git",
    "**/.github",
    "**/.idea",
    "**/.vs",
    "**/.vscode",
    "**/.zed",
    "**/node_modules"
  ],
  "terminal": {
      "shell": {
          "with_arguments": {
              "program": "C:\\Program Files\\Git\\bin\\sh.exe",
              "args": ["-i"]
          }
      },
      "font_family": "Intel One Mono",
      "font_size": 16
  },
}
```

- 快捷键设置

```json
[
  {
    "context": "Editor", // 定义上下文，例如只在编辑器中生效
    "bindings": {
      "ctrl-alt-s": "editor::SaveAll" // 自定义组合键保存所有文件
    }
  }
]
```

- 按语言配置

```json
{
  "languages": {
    "Markdown": {
      "tab_size": 2,
      "hard_tabs": true,
      "soft_wrap": "editor_width"
    }
  }
}
```

- 设置终端

```json
{
  "terminal": {
    "shell": {
        "with_arguments": {
        "program": "C:\\Program Files\\Git\\bin\\sh.exe",
            "args": ["-i"]
        }
    },
    "font_family": "Intel One Mono"
  }
}
```

## 使用文档

## 1. 基础操作

### 1.1 打开/关闭文件与项目

- **打开文件/文件夹：**
  - 通过菜单 `File` -> `Open...` 或 `Open Folder...`。
  - 使用快捷键 `Ctrl + O` (Windows/Linux) 或 `Cmd + O` (macOS) 打开文件。
  - 使用快捷键 `Ctrl + Shift + O` (Windows/Linux) 或 `Cmd + Shift + O` (macOS) 打开文件夹。
- **最近打开：** `File` -> `Open Recent`。
- **关闭文件：** `Ctrl + W` (Windows/Linux) 或 `Cmd + W` (macOS)。
- **关闭窗口：** `Ctrl + Shift + W` (Windows/Linux) 或 `Cmd + Shift + W` (macOS)。

### 1.2 命令面板

Zed 的核心是**命令面板**，通过它您可以快速执行各种操作。

- **打开命令面板：** `Ctrl + Shift + P` (Windows/Linux) 或 `Cmd + Shift + P` (macOS)。
- **常用命令：**
  - `zed: open project settings`：打开当前项目的设置。
  - `zed: open user settings`：打开 Zed 的全局用户设置。
  - `zed: open key bindings`：查看并修改快捷键绑定。
  - `file: go to file`：快速跳转到项目中的文件。
  - `editor: toggle comment`：注释/取消注释选中的行。

---

## 2. 文件导航与搜索

### 2.1 文件树 (左侧面板)

左侧面板显示当前项目的文件树。

- **显示/隐藏文件树：** 通常有一个对应的命令 (`workspace::ToggleLeftDock`)，你可以通过命令面板搜索并为其设置快捷键。
- **新建文件/文件夹：** 在文件树中右键点击，选择 `New File` 或 `New Folder`。
- **重命名/删除：** 在文件树中右键点击文件/文件夹，选择相应操作。

### 2.2 快速文件跳转

- **Go to File：** `Ctrl + P` (Windows/Linux) 或 `Cmd + P` (macOS)。输入文件名，Zed 会实时搜索并显示匹配项。

### 2.3 文本搜索与替换

- **当前文件搜索：** `Ctrl + F` (Windows/Linux) 或 `Cmd + F` (macOS)。
- **当前文件替换：** `Ctrl + H` (Windows/Linux) 或 `Cmd + H` (macOS)。
- **全局搜索 (在项目中搜索)：** `Ctrl + Shift + F` (Windows/Linux) 或 `Cmd + Shift + F` (macOS)。
- **全局替换：** `Ctrl + Shift + H` (Windows/Linux) 或 `Cmd + Shift + H` (macOS)。

[快捷键列表](https://zed.dev/docs/key-bindings)

---

## 3. 编辑功能

### 3.1 多光标编辑

- **添加/删除光标：** 按住 `Alt` (Windows/Linux) 或 `Option` (macOS) 并在不同位置点击。
- **选择所有匹配项：** 选中一个文本，然后按 `Ctrl + D` (Windows/Linux) 或 `Cmd + D` (macOS) 逐个选中下一个匹配项，或 `Ctrl + Shift + L` (Windows/Linux) 或 `Cmd + Shift + L` (macOS) 选中所有匹配项。

### 3.2 代码折叠

- **折叠/展开代码块：** 通常在行号旁边有小箭头，点击即可。也可以通过命令面板搜索相关命令。

### 3.3 自动完成与 LSP

Zed 内置了对 LSP (Language Server Protocol) 的支持，提供智能代码补全、定义跳转、引用查找等功能。

- **触发自动完成：** 通常在输入时自动弹出，或按 `Ctrl + Space` (Windows/Linux) 或 `Cmd + Space` (macOS) 手动触发。
- **跳转到定义：** 将光标放在函数或变量上，按 `F12` 或右键选择 `Go to Definition`。

---

## 4. 自定义与扩展

### 4.1 设置 (Settings)

Zed 的设置以 JSON 格式存储，分为用户设置和项目设置。

- **用户设置：** 影响所有 Zed 实例和项目。
- **项目设置：** 仅影响当前打开的项目，优先级高于用户设置。
- **打开方式：** 通过命令面板搜索 `zed: open user settings` 或 `zed: open project settings`。

## 5. 疑难解答

- **性能问题：** 检查 file_scan_exclusions 是否配置得当，排除不必要的文件和文件夹。
- **功能不正常：** 尝试重启 Zed。
- **查看日志：** 可以通过命令面板找到 zed: open logs 来查看 Zed 的运行日志。
