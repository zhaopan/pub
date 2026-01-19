# vscode

## 常用命令

```bash
# 正则表达式去掉空行
^\s*(?=\r?$)\n

##
## 检查重复行(开启正则表达式搜索)
##
^(.+)((?:\r?\n.*)*)(?:\r?\n\1)$

##
## 替换重复行(开启正则表达式搜索)
##
$1$2
```

## lookup extensions-list

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

## list-extensions-installed

- code --install-extension `benawad.VSinder`
- code --install-extension `bierner.markdown-mermaid`
- code --install-extension `bpruitt-goddard.mermaid-markdown-syntax-highlighting`
- code --install-extension `eamodio.gitlens`
- code --install-extension `felixfbecker.php-debug`
- code --install-extension `fernandoescolar.vscode-solution-explorer`
- code --install-extension `gamunu.vscode-yarn`
- code --install-extension `GitHub.github-vscode-theme`
- code --install-extension `golang.go`
- code --install-extension `k--kato.docomment`
- code --install-extension `mhutchie.git-graph`
- code --install-extension `ms-azuretools.vscode-docker`
- code --install-extension `MS-CEINTL.vscode-language-pack-zh-hans`
- code --install-extension `ms-dotnettools.csharp`
- code --install-extension `ms-vscode-remote.remote-containers`
- code --install-extension `ms-vscode-remote.remote-ssh`
- code --install-extension `ms-vscode-remote.remote-ssh-edit`
- code --install-extension `ms-vscode-remote.remote-wsl`
- code --install-extension `ms-vscode-remote.vscode-remote-extensionpack`
- code --install-extension `ms-vscode.powershell`
- code --install-extension `ms-vscode.sublime-keybindings`
- code --install-extension `octref.vetur`
- code --install-extension `redhat.vscode-xml`
- code --install-extension `Spades.vs-picgo`
- code --install-extension `vstirbu.vscode-mermaid-preview`
- code --install-extension `WakaTime.vscode-wakatime`
- code --install-extension `yzane.markdown-pdf`

### 插件

- `Docker`              Docker
- `Git Graph`           Git Graph
- `Git History`         Git History
- `Markdown PDF`        Markdown To PDF
- `Prettify JSON`       json Format
- `Sublime Text Keymap and Settings Importer`
- `VSCode Great Icons`
- `vscode-icons`
- `vscode-pdf`
- `vscode-solution-explorer`

### markdown 转 PDF

安装插件 `Markdown PDF`

若点击转PDF失败，需要添加配置

> windows

```yml
"markdown-pdf.executablePath": "C:\\\\Program Files\\\\Google\\\\Chrome\\\\Application\\\\chrome.exe"
```

> macOS

```yml
"markdown-pdf.executablePath": "/GoogleChrome/Application/chrome"
```

## user.setting

```json
{
    "window.zoomLevel": 0,
    //让函数(名)和后面的括号之间加个空格
    "javascript.format.insertSpaceBeforeFunctionParenthesis": true,
    // gitfetch
    "git.autofetch": true,
    // 去除行末尾的空格
    "files.trimTrailingWhitespace": true,
    // 文件末尾插入新行
    "files.insertFinalNewline": true,
    // 编辑器换行
    "editor.wordWrap": "off",
    // 重新设定tabsize
    "editor.tabSize": 4,
    // 显示所有空行
    "editor.renderWhitespace": "all",
    // 禁用 minimap
    "editor.minimap.enabled": false,
    // 每次保存的时候自动格式化
    "editor.formatOnSave": true,
    // vscode默认启用了根据文件类型自动设置tabsize的选项
    "editor.detectIndentation": true,
    "editor.codeLens": false,
    "editor.fontFamily": "JetBrains Mono",
    "editor.unicodeHighlight.nonBasicASCII": false,
    // 文件路径导航
    "breadcrumbs.enabled": true,
    "workbench.colorTheme": "Default Dark+",
    "workbench.startupEditor": "none",
    "explorer.confirmDelete": false,
    "explorer.confirmDragAndDrop": false,
    "gitHistory.showEditorTitleMenuBarIcons": false,
    // codeLens
    "gitlens.codeLens.enabled": false,
    "gitlens.codeLens.authors.enabled": false,
    "gitlens.codeLens.recentChange.enabled": false,
    "gitlens.views.commitDetails.files.layout": "list",
    // diffEditor
    "diffEditor.experimental.showMoves": true,
    "diffEditor.renderSideBySide": true,
    "diffEditor.useInlineViewWhenSpaceIsLimited": false,
    // remote
    "remote.SSH.showLoginTerminal": true,
    "remote.SSH.remotePlatform": {
        "ts01": "linux",
        "ts02": "linux",
        "ts03": "linux"
    },
    // proxy
    "http.proxy": "http://127.0.0.1:7890",
    "http.proxyAuthorization": null,
    "http.proxySupport": "on",
    "http.proxyStrictSSL": false,
    // terminal
    "terminal.integrated.fontFamily": "JetBrains Mono",
    "terminal.integrated.defaultProfile.windows": "Git Bash",
    // markdown
    "markdown-pdf.displayHeaderFooter": false,
    "[markdown]": {
        "editor.defaultFormatter": "yzhang.markdown-all-in-one"
    },
    "files.associations": {
        "*.md": "markdown",
        "*.caddy": "caddyfile"
    },
    "markdown-pdf.executablePath": "C:\\\\Program Files\\\\Google\\\\Chrome\\\\Application\\\\chrome.exe",
    "files.exclude": {
        "DS_Store": true,
        "_config.yml": true,
        ".git": true,
        ".gitattributes": true,
        ".github": true,
        ".idea": true,
        ".obsidian": true,
        ".vs": true,
        ".vscode": true,
        ".zed": true,
        "dist": true,
        "node_modules": true,
    },
    "terminal.integrated.profiles.windows": {
        "Git Bash": {
            "source": "Git Bash",
        }
    },
}
```
