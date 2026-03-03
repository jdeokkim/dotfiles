#!/bin/sh

# ============================================================================

sudo xbps-install vim

mkdir -p ~/.vim/autoload/

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ============================================================================>
