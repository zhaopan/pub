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

## user.setting

[vscode-user-setting](vscode-setting.md#user.setting)

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
