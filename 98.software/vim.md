# vim | Vim 配置（完整实战版）

本文件是 `vim` 的详细配置实战手册，涵盖：

- ✅ vimrc 核心配置项说明
- ✅ 插件管理方案（Vundle / Vim-Plug）
- ✅ 常用键位映射与注释逻辑
- ✅ 插件推荐与实战用法

---

## 📁 配置文件说明

- 用户配置文件路径：`~/.vimrc`
- 插件路径（Vundle）：`~/.vim/bundle/`
- 插件路径（Plug）：`~/.vim/plugged/`

---

## 🧩 vimrc 核心配置片段

```vim
set number                        " 显示行号
set relativenumber               " 显示相对行号
set tabstop=4                    " tab 宽度为 4 空格
set shiftwidth=4
set expandtab                    " 替换为空格
set autoindent
set cursorline                   " 高亮当前行
syntax on                        " 启用语法高亮
filetype plugin indent on        " 启用文件类型检测
```

> 🧠 注释说明：
> - `expandtab` 是防止 Python 缩进错误的老救星
> - `cursorline` 在复杂 YAML 文件中特别有用

---

## 🔌 插件管理（以 Vundle 为例）

### 安装 Vundle：

```bash
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
```

### vimrc 插件段落

```vim
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on
```

### 启动 vim 后执行安装

```vim
:PluginInstall
```

---

## 🧠 常用快捷键与映射建议

```vim
nmap <F2> :NERDTreeToggle<CR>       " F2 快捷开启目录树
nmap <leader>w :w<CR>               " leader+w 快速保存
```

### 插件快捷键示例

- `<F2>` NERDTree 切目录
- `gcc` 快速注释当前行（vim-commentary）
- `:AirlineTheme` 切换状态栏主题

---

## 🧪 实战使用场景

- 前端开发配置中需快速跳转/折叠 js 函数段落（配合 vim-markdown）
- 远程调试脚本使用 `NERDTree + vim-airline` 提高导航效率
- `.vimrc` 拷贝到远程机器配合 `scp` 统一体验

---

## 🛠️ 常见问题与解决

| 问题         | 可能原因                          | 解决方法                         |
| ------------ | --------------------------------- | -------------------------------- |
| 插件不生效   | 未执行 PluginInstall / vimrc 有错 | 检查语法后重新加载               |
| 中文乱码     | 编码设置问题                      | `set encoding=utf-8` 加入 vimrc  |
| 折叠功能无效 | 缺少文件类型检测                  | 加上 `filetype plugin indent on` |

---

## 🧠 历史注释与踩坑记录

- `filetype plugin indent on` 是折叠/缩进/注释插件必须依赖项，之前忘加导致功能失效
- `vim-commentary` 比 `NERDCommenter` 更轻便，无需配置
- `NERDTree` 曾影响终端调试流畅性，建议搭配快捷键使用而非默认开启

> 📁 本文档建议放入 `/software/full-config/vim-deep.md`，用于日常远程调试环境快速部署。
