#!/bin/bash

#
# Copyright (c) 2024 Jaedeok Kim (jdeokkim@protonmail.com)
#

BAR_PIPE=~/.config/sdorfehs/bar

BAR_PID=$(pgrep -f -o "bash .*/bar-script.sh")

if [ ! $$ = $BAR_PID ]; then
    kill -9 $BAR_PID
fi

DAY_NAMES=(
#    "^fg(red)(일)^fg()" 
    "(일)"
    "(월)" 
    "(화)" 
    "(수)" 
    "(목)" 
    "(금)" 
#    "^fg(blue)(토)^fg()"
    "(토)"
)

while true; do
    DAY_INDEX=$(date +"%w")

    TIME=$(date +"%y년 %m월 %d일 ${DAY_NAMES[$DAY_INDEX]} | %H:%M:%S")
    
    printf "$TIME\n" > $BAR_PIPE 

    sleep 0.1
done
