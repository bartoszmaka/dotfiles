#!/bin/bash

ostype="$(uname -s)"
vscode_dir=''
case "$ostype" in
  Linux*) vscode_dir=$HOME'/.config/Code/User';;
  Darwin*) vscode_dir=$HOME'/Library/Application Support/Code/User';;
esac

code --list-extensions >> $DOTFILES_PATH/vscode/extensions_list.txt
cp -v "$vscode_dir"/settings.json $DOTFILES_PATH/vscode/settings.json
cp -v "$vscode_dir"/keybindings.json $DOTFILES_PATH/vscode/keybindings.json
cp -vr "$vscode_dir"/snippets $DOTFILES_PATH/vscode
