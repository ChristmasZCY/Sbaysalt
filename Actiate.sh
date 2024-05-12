#!/usr/bin/env bash
#  -*- coding:UTF-8 -*-:

current_shell=$SHELL

# 通过判断也可以做出更详细的处理
if [[ "$current_shell" == */bash ]]; then
    envFile="$HOME/.bashrc"
elif [[ "$current_shell" == */zsh ]]; then
    envFile="$HOME/.zshrc"
elif [[ "$current_shell" == */csh ]]; then
    envFile="$HOME/.cshrc"
else
    echo "Unknown shell: $current_shell"
    exit 1
fi

#sfilepath=$(readlink -f "$0")
sfilepath=$(realpath "$0")
path=$(dirname "$sfilepath")

if ! printenv PATH | grep -q "$path"; then
    cp "$envFile" $path/$(basename "$envFile")_$(date +%Y%m%d%H%M%S)_bak
    echo "export PATH=\$PATH:$path" >> "$envFile"
    echo "export PATH=\$PATH:$path"
    echo "Please run 'source $envFile' to update your PATH"
fi


