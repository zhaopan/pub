# gh-bash

## 尝试直接对某个仓库执行

```bash
# 清理了当前目录仓库所有失败记录
gh run list --status failure --limit 100 --json databaseId -q '.[].databaseId' | xargs -r -I{} gh run delete {}
```

## 删除所有仓库执行失败的Action

git-bash

```bash
gh repo list --limit 1000 --json nameWithOwner --source -q '.[].nameWithOwner' | while read repo; do
  echo ">>> 正在清理仓库: $repo"
  ids=$(gh run list --repo "$repo" --status failure --limit 100 --json databaseId -q '.[].databaseId')
  if [ -n "$ids" ]; then
    echo "$ids" | xargs -I{} gh run delete --repo "$repo" {}
    echo ">>>清理完成。"
  else
    echo ">>>没有发现失败记录。"
  fi
done
```

awk

```bash
gh repo list --limit 1000 --source | awk '{print $1}' | while read repo; do
  echo ">>> 正在清理仓库: $repo"
  gh run list --repo "$repo" --status failure --limit 100 --json databaseId -q '.[].databaseId' | xargs -r -I{} gh run delete --repo "$repo" {}
done
```
