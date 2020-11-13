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
            echo "- ["$ELEMENT"]("$URL"/tree/master/"$DIR_OR_FILE")"
            COUNT=`expr $COUNT + 1`
            getdir $DIR_OR_FILE $COUNT
            COUNT=1
        else
            echo "  - ["$ELEMENT"]("$URL"/blob/master/"$ELEMENT")"
        fi
    done
}

ROOT_DIR="."
URL='https://github.com/zhaopan/codesnippet'
getdir $ROOT_DIR 1
