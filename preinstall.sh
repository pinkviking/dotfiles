#!/bin/bash

# Install Oh-My-Zsh
if [ "$ZSH" == "" -a -f "/bin/bash" ]; then
    rm -rf ~/.oh-my-zsh
    echo "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
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

if [ -f ~/.zshrc ]; then
    if [ ! -L ~/.zshrc ]; then rm ~/.zshrc; fi
fi

if [ -f ~/.bashrc ]; then
    if [ ! -L ~/.bashrc ]; then rm ~/.bashrc; fi
fi

