#
# Copyright (c) 2024 Jaedeok Kim (jdeokkim@protonmail.com)
#

# ============================================================================>

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ============================================================================>

alias ls='ls --color=auto'

# ============================================================================>

alias discord='flatpak run com.discordapp.Discord'

# ============================================================================>

source ~/.git-prompt.sh

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; 

# PS1='[\u@\h \W]\$ '
PS1='\w\[\e[32m\]${PS1_CMD1}\[\e[0m\] \[\e[92;1m\]\\$\[\e[0m\] '

# ============================================================================>
