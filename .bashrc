#
# Copyright (c) 2024 Jaedeok Kim (jdeokkim@protonmail.com)
#

# ============================================================================>

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ============================================================================>

alias ls='ls --color=auto'

# ============================================================================>

PS1='[\u@\h \W]\$ '

# ============================================================================>

export GLFW_IM_MODULE=ibus
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# ============================================================================>
