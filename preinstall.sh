#!/bin/bash

if [ "$ZSH" == "" -a -f "/bin/bash" ]; then sh  -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; fi

