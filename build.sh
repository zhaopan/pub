#!/bin/bash

getdir(){
    COUNT=1
    if [ $COUNT -ne $2 ]
    then
        COUNT=$2
    fi
    for ELEMENT in `ls $1`
    do
        DIR_OR_FILE=$1"/"$ELEMENT
        if [ -d $DIR_OR_FILE ]
        then
            echo "${SPACE_STR:0:$COUNT}- ["$ELEMENT"]("${DIR_OR_FILE/.\//}")" >> README.md
            COUNT=`expr $COUNT + 2`
            getdir $DIR_OR_FILE $COUNT
            COUNT=$2
        else
            if [[ $DIR_OR_FILE == *.md ]] # 过滤非 *.md 文档
            then
                echo "${SPACE_STR:0:$COUNT}- ["$ELEMENT"]("${DIR_OR_FILE/.\//}")" >> README.md
            fi
        fi
    done
}

SPACE_STR="                                          "
ROOT_DIR="."

tee README.md <<-'EOF'
# 个人知识库整理

[![wakatime](https://wakatime.com/badge/github/zhaopan/pub.svg)](https://wakatime.com/badge/github/zhaopan/pub)

该知识库都是日常记录的，用于备忘、方便查询，防老年痴呆。

<!-- TOC -->

EOF

echo 'Append document to README.md'

getdir $ROOT_DIR 0

tee -a README.md <<-'EOF'

<!-- /TOC -->
EOF
