# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# Set up some environment variables for fcitx5
export GLFW_IM_MODULE=ibus
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Disable XON/XOFF flow control
stty -ixon
