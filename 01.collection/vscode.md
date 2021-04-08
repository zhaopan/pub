# vscode

## user.setting

```json
{
    "editor.renderWhitespace": "all",
    "files.insertFinalNewline": true,
    "files.trimTrailingWhitespace": true,
    "git.autofetch": true,
    "window.zoomLevel": 0,
}
```

## lookup extensions-list

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```

### list-extensions-installed

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


### remark

```bash
# 正则表达式去掉空行
^\s*(?=\r?$)\n
```
