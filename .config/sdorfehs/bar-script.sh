#!/bin/bash

#
# Copyright (c) 2024 Jaedeok Kim (jdeokkim@protonmail.com)
#

# ============================================================================>

_bar_pid=$(pgrep -f -o "bash .*/bar-script.sh");
_bar_pipe=~/.config/sdorfehs/bar;

_day_names=(
    "(일)"
    "(월)" 
    "(화)" 
    "(수)" 
    "(목)" 
    "(금)" 
    "(토)"
);

_has_batteries=$(acpi 2>/dev/null | grep -q 'Battery'; echo $? | bc);

_separator='^fg(#6A6D8F)/^fg()';

# ============================================================================>

battery_emoji='^fn(Noto Color Emoji)🔋^fn()';
battery_info="$battery_emoji -%%";

sound_emoji='^fn(Noto Color Emoji)🔊^fn()';
sound_info="$sound_emoji -%%";

# ============================================================================>

update_battery_status() {
    if [ $_has_batteries -eq 0 ]; then
        battery_status=$(acpi | grep -q 'Charging'; echo $?);
        
        if [ $battery_status -eq 1 ]; then
            battery_emoji='^fn(Noto Color Emoji)🔋^fn()';
        else
            battery_emoji='^fn(Noto Color Emoji)🔌^fn()';
        fi

        battery_value=$(acpi | grep -o '[0-9]*%');

        if [ -z $battery_value ]; then
            battery_value="-%";
        fi

        battery_info="$battery_emoji $battery_value%";
    fi
}

update_sound_status() {
    is_sound_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ \
        | grep -q 'MUTED'; echo $? | bc);

    if [ $is_sound_muted -eq 0 ]; then
        sound_emoji='^fn(Noto Color Emoji)🔇^fn()';
    else
        sound_emoji='^fn(Noto Color Emoji)🔊^fn()';
    fi

    sound_volume=$(echo "scale=0;100*($(wpctl get-volume \
        @DEFAULT_AUDIO_SINK@ | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))/1" \
        | bc
    );

    if [ -z $sound_volume ]; then
        sound_volume="-";
    fi

    sound_info="$sound_emoji $sound_volume%%"; 
}

# ============================================================================>

while true; do
    output_str="$_separator ^ca(1,sh -c 'pavucontrol')$sound_info^ca()";
    
    if [ $_has_batteries -eq 0 ]; then
        output_str="${output_str} $_separator $battery_info";
    fi
        
    day_index=$(date +"%w");
    
    date_info=$(date +"%y년 %m월 %d일 ${_day_names[$day_index]}");
    time_info=$(date +"%H:%M:%S");
    
    output_str="${output_str} $_separator $date_info";
    output_str="${output_str} $_separator $time_info";

    printf "$output_str\n" > $_bar_pipe;

    update_battery_status;
    update_sound_status;

    sleep 0.75; 
done
