#!/bin/bash

#
# Copyright (c) 2024 Jaedeok Kim (jdeokkim@protonmail.com)
#

# ============================================================================>

BAR_PID=$(pgrep -f -o "bash .*/bar-script.sh")
BAR_PIPE=~/.config/sdorfehs/bar

DAY_NAMES=(
    "(일)"
    "(월)" 
    "(화)" 
    "(수)" 
    "(목)" 
    "(금)" 
    "(토)"
)

SEPARATOR='^fg(#6A6D8F)/^fg()'

# ============================================================================>

BATTERY_EMOJI='^fn(Noto Color Emoji)🔋^fn()'
BATTERY_PERCENT_STR="$BATTERY_EMOJI -%%"

HAS_BATTERY=$(acpi 2>/dev/null | grep -q 'Battery'; echo $? | bc)

SOUND_EMOJI='^fn(Noto Color Emoji)🔊^fn()'
SOUND_PERCENT_STR="$SOUND_EMOJI -%%"

# ============================================================================>

update_battery_status() {
    if [ $HAS_BATTERY -eq 0 ]; then
        BATTERY_STATUS=$(acpi | grep -q 'Charging'; echo $?)
        
        if [ $BATTERY_STATUS -eq 1 ]; then
            BATTERY_EMOJI='^fn(Noto Color Emoji)🔋^fn()'
        else
            BATTERY_EMOJI='^fn(Noto Color Emoji)🔌^fn()'
        fi

        BATTERY_VALUE=$(acpi | grep -o '[0-9]*%')

        if [ -z $BATTERY_VALUE ]; then
            BATTERY_VALUE="-%"
        fi

        BATTERY_PERCENT_STR="$BATTERY_EMOJI $BATTERY_VALUE%"
    fi
}

update_sound_status() {
    IS_SOUND_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ \
        | grep -q 'MUTED'; echo $? | bc)

    if [ $IS_SOUND_MUTED -eq 0 ]; then
        SOUND_EMOJI='^fn(Noto Color Emoji)🔇^fn()'
    else
        SOUND_EMOJI='^fn(Noto Color Emoji)🔊^fn()'
    fi

    SOUND_VOLUME=$(echo "scale=0;100*($(wpctl get-volume \
        @DEFAULT_AUDIO_SINK@ | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))/1" \
        | bc
    );

    if [ -z $SOUND_VOLUME ]; then
        SOUND_VOLUME="-"
    fi

    SOUND_PERCENT_STR="$SOUND_EMOJI $SOUND_VOLUME%%"    
}

# ============================================================================>

while true; do
    OUTPUT_STR="$SEPARATOR $SOUND_PERCENT_STR";
    
    if [ $HAS_BATTERY -eq 0 ]; then
        OUTPUT_STR="${OUTPUT_STR} $SEPARATOR $BATTERY_PERCENT_STR";
    fi
        
    DAY_INDEX=$(date +"%w")
    
    DATE_STR=$(date +"%y년 %m월 %d일 ${DAY_NAMES[$DAY_INDEX]}")
    TIME_STR=$(date +"%H:%M:%S")
    
    OUTPUT_STR="${OUTPUT_STR} $SEPARATOR $DATE_STR";
    OUTPUT_STR="${OUTPUT_STR} $SEPARATOR $TIME_STR";

    printf "$OUTPUT_STR\n" > $BAR_PIPE;

    update_battery_status;
    update_sound_status;

    sleep 0.5; 
done
