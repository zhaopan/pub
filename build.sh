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
            echo "${SPACE_STR:0:$COUNT}- ["$ELEMENT"]("$URL"/tree/master/"${DIR_OR_FILE/.\//}")" >> README.md
            COUNT=`expr $COUNT + 2`
            getdir $DIR_OR_FILE $COUNT
            COUNT=$2
        else
            echo "${SPACE_STR:0:$COUNT}- ["$ELEMENT"]("$URL"/blob/master/"${DIR_OR_FILE/.\//}")" >> README.md
        fi
    done
}

SPACE_STR="                                          "
ROOT_DIR="."
URL='https://github.com/zhaopan/pub'

tee README.md <<-'EOF'
# 个人代码片段整理

[![wakatime](https://wakatime.com/badge/github/zhaopan/pub.svg)](https://wakatime.com/badge/github/zhaopan/pub)

这些代码片段都是以前日常记录的，用于备忘和方便查询，防老年痴呆。

<!-- TOC -->

EOF

echo 'Append document to readme.md'

getdir $ROOT_DIR 0

tee -a README.md <<-'EOF'

<!-- /TOC -->
EOF
