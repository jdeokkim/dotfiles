#!/bin/bash

#
# Copyright (c) 2024 Jaedeok Kim (jdeokkim@protonmail.com)
#

BAR_PIPE=~/.config/sdorfehs/bar

DAY_NAMES=("일" "월" "화" "수" "목" "금" "토")

while true; do
    DAY_INDEX=$(date +"%w")

    TIME=$(date +"%y년 %m월 %d일 (${DAY_NAMES[$DAY_INDEX]}) | %H:%M:%S")
    
    printf "$TIME\n" > $BAR_PIPE 

    sleep 0.1
done
