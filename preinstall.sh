#!/bin/bash

# Install Oh-My-Zsh
if [ "$ZSH" == "" -a -f "/bin/bash" ]; then 
    echo "Installing Oh-My-Zsh"
    sh  -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install vimplug
vimplug="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim 
if [ ! -f "$vimplug" ]; then
    echo "Installing vimplug"
    sh -c 'curl -fLo \
        "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
        --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi


