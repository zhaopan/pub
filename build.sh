#!/bin/bash

# 排除规则配置（支持通配符）
EXCLUDE_PATTERNS=(
  ".idea/"
  ".obsidian/"
  ".vscode/"
  ".zed/"
  "CODE_OF_CONDUCT.md"
  "CONTRIBUTING.md"
  "README.md"
  "SUMMARY.md"
  "intractable-disease.md"
  "naming-abbreviation.md"
  "*-debug.md"                            # 匹配所有以-debug.md结尾的文件
  "*/log4net/"                            # 匹配任何目录下的这个特定文件
  "*/temp/*"                              # 匹配任何temp子目录
)

# 增强版路径排除检查（支持所有通配符）
should_exclude() {
  local target="$1"
  target="${target#./}"
  target="${target%/}"

  for pattern in "${EXCLUDE_PATTERNS[@]}"; do
    # 判断是否是目录模式（以/结尾）
    if [[ "$pattern" == */ ]]; then
      # 目录通配符匹配（如 */subdir/ 或 *temp*/）
      if [[ "$pattern" == *\** ]]; then
        [[ "$target" == ${pattern%/} || "$target" == ${pattern%/}/* ]] && return 0
      else
        # 普通目录匹配
        [[ "$target" == "${pattern%/}" || "$target" == "${pattern%/}"/* ]] && return 0
      fi
    else
      # 文件/路径通配符匹配
      [[ "$target" == $pattern ]] && return 0
    fi
  done
  return 1
}

# 生成导航内容
generate_nav() {
  echo "## 文件目录导航"
  echo ""

  # 递归目录处理函数
  process_directory() {
    local dir="$1"
    local indent="$2"

    # 检查目录是否有有效内容
    local has_content=false
    while IFS= read -r -d '' file; do
      filepath="${file#./}"
      if ! should_exclude "$filepath"; then
        has_content=true
        break
      fi
    done < <(find "$dir" -maxdepth 1 \( -type f -name "*.md" -o -type d \) -print0)

    # 无有效内容则跳过
    ! $has_content && return

    # 输出目录标题
    [[ "$dir" != "." ]] && echo "${indent}- [$(basename "$dir")/]($dir)"

    # 输出文件列表
    while IFS= read -r -d '' file; do
      filepath="${file#./}"
      ! should_exclude "$filepath" && [[ -f "$file" ]] && \
        echo "${indent}  - [$(basename "$file")]($filepath)"
    done < <(find "$dir" -maxdepth 1 -type f -name "*.md" -print0 | sort -z)

    # 处理子目录
    while IFS= read -r -d '' subdir; do
      [[ "$subdir" != "$dir" && "$subdir" != *".git"* ]] && \
        process_directory "$subdir" "${indent}  "
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
  }

  # 从根目录开始处理
  process_directory "." ""
}

# 更新README文件
update_readme() {
  echo "🔄 正在生成文件目录导航..."
  echo "📝 排除规则: ${EXCLUDE_PATTERNS[*]}"

  # 生成导航内容并去除行首空格
  nav_content=$(generate_nav | sed 's/^  //')

  # 更新README.md
  awk -v nav="$nav_content" '
    BEGIN {in_toc=0}
    /^<!-- FILE NAV START -->/ {
      print; printf "%s", nav; in_toc=1; next
    }
    /^<!-- FILE NAV END -->/ {in_toc=0; print; next}
    !in_toc {print}
  ' README.md > README.tmp && mv README.tmp README.md

  echo "✅ 导航生成完成!"
  echo "🔍 生成结果预览:"
  grep -A 15 "<!-- FILE NAV START -->" README.md || echo "⚠️ 未检测到导航内容"
}


tee README.md <<-'EOF'
# 个人知识库整理

[![wakatime](https://wakatime.com/badge/github/zhaopan/pub.svg)](https://wakatime.com/badge/github/zhaopan/pub)

该知识库都是日常记录的，用于备忘、方便查询，防老年痴呆。

<!-- TOC -->

<!-- FILE NAV START -->

## 文件目录导航

EOF

echo 'Append document to README.md'

# 执行主流程
update_readme

tee -a README.md <<-'EOF'

<!-- FILE NAV END -->

<!-- /TOC -->
EOF
