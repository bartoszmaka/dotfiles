#!/bin/bash

ostype="$(uname -s)"
vscode_dir=''
case "$ostype" in
  Linux*) vscode_dir=$HOME'/.config/Code/User';;
  Darwin*) vscode_dir=$HOME'/Library/Application Support/Code/User';;
esac

cat $DOTFILES_PATH/vscode/extensions_list.txt | xargs -n 1 code --install-extension
cp -vf $DOTFILES_PATH/vscode/settings.json  "$vscode_dir"/settings.json
cp -vf $DOTFILES_PATH/vscode/keymaps.json "$vscode_dir"/keymaps.json
cp -vfr $DOTFILES_PATH/vscode/snippets "$vscode_dir"/snippets
