# Claude Code

## 安装与更新

```bash
npm install -g @anthropic-ai/claude-code
npm view @anthropic-ai/claude-code version
npm update -g @anthropic-ai/claude-code
```

## 常用命令

```bash
claude                        # 启动对话
claude --help                 # 查看帮助
claude --version              # 查看版本
```

## 配置

- 配置文件: `~/.claude/settings.json`
- 项目级配置: `.claude/settings.json`
- 项目级本地配置: `.claude/settings.local.json`

## 快捷命令

| 命令 | 说明 |
|------|------|
| `/help` | 显示帮助信息 |
| `/clear` | 清除会话历史 |
| `/review` | 代码审查 |
| `/verify` | 验证代码变更 |
| `/config` | 修改设置 |

## 权限配置

在 `settings.json` 中配置允许的命令和权限:

```json
{
  "permissions": {
    "allow": ["Bash", "Read", "Write"]
  }
}
```

## MCP 服务器

通过 `settings.json` 配置 MCP 服务器连接:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@server/package"]
    }
  }
}
```

## 技巧

- 使用 `/verbose` 查看详细输出
- 使用 `/compact` 压缩上下文
- 在项目目录中运行以获得更好的上下文感知
- 使用 `@file` 引用特定文件内容
