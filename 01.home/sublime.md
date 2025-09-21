# sublime

## user.setting

```json
{
  "auto_find_in_selection": true,
  "bold_folder_labels": true,
  "draw_white_space": "all",
  "ensure_newline_at_eof_on_save": true,
  "font_face":"Intel One Mono",
  "font_size": 10,
  "highlight_line": true,
  "highlight_modified_tabs": true,
  "index_files": true,
  "save_on_focus_lost": true,
  "show_encoding": true,
  "show_line_endings": true,
  "tab_size": 4,
  "translate_tabs_to_spaces": true,
  "trim_automatic_white_space": true,
  "trim_trailing_white_space_on_save": true,
  "update_check": false,
  "word_wrap": false,
  "associations": {
      "*.vue": "source.js.babel",
  }
}
```

## user key bingings

```json
[
  {
    "keys": [
      "alt+1"
    ],
    "command": "terminus_open",
    "args": {
      "cwd": "${file_path:${folder}}"
    }
  },
  {
    "keys": [
      "alt+`"
    ],
    "command": "toggle_terminus_panel",
    "args": {
      "cwd": "${file_path:${folder}}"
    }
  }
]
```

## `Windows` Terminus->Setting 设置默认 终端

```txt
{
    "shell_configs": [
    {
        "name": "Git Bash",
        "cmd": ["C:/Program Files/Git/bin/bash.exe", "--login", "-i"],
        "env": {},
        "enable": true,
        "default": true  // 设为默认终端
    }],
}
```

## extensions

- `DeleteBlankLines`    删除空白行
- `DocBlockr`           注释
- `JsFormst`            JS格式化
- `PrettyJson`          json格式化
- `SFTP`                FTP同步
- `theme-Afterglow`     主题样式
- `sublimerge`          文件对比
- `Terminus`            命令行插件
- `Dockerfile Syntax Highlighting`
- `LSP`
- `LSP-dockerfile`
- `LSP-vue`
- `LSP-yaml`
- `nginx`
- `Package Control`
- `Terminus`

## LSP

### Package Control -> Install Package Control -> LSP

```txt
LSP：这是核心插件，用于连接各种语言服务器
LSP-vue：用于支持 Vue 文件的语言服务
LSP-yaml：用于支持 YAML 文件的语言服务
LSP-dockerfile：用于支持 Dockerfile 的语言服务
```

### Install LSP Server

```bash
npm install -g @vue/language-server
npm install -g yaml-language-server
npm install -g docker-langserver
npm install -g docker-langserver
```

### Preferences -> Package Settings -> LSP -> Settings

```yml
{
    "clients": {
        "vue-language-server": {
            "enabled": true,
            "command": ["vue-language-server", "--stdio"],
            "scopes": ["text.html.vue"],
            "syntaxes": ["Packages/LSP-vue/vue.sublime-syntax"],
            "priority_match": "auto",
            "settings": {
                // 这里可以添加 Volar 的特定配置，比如 volar.format.enable
            }
        },
        "yaml-language-server": {
            "enabled": true,
            "command": ["yaml-language-server", "--stdio"],
            "scopes": ["source.yaml"],
            "syntaxes": ["Packages/LSP-yaml/YAML.sublime-syntax"],
            "priority_match": "auto",
        },
        "dockerfile-language-server": {
            "enabled": true,
            "command": ["docker-langserver", "--stdio"],
            "scopes": ["source.dockerfile"],
            "syntaxes": ["Packages/LSP-dockerfile/Dockerfile.sublime-syntax"],
            "priority_match": "auto",
        }
    }
}
```
