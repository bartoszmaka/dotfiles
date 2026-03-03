#### basic custom vim shortcuts

![image](https://user-images.githubusercontent.com/12910127/133265699-e045686c-1f9a-4b0e-a155-d3f26913843a.png)

| description                                                   | mapping
| --------------------------------------------------------------|--------------
| --- LSP ---
| go to definition                                              | `gd`
| go to references                                              | `gr`
| fix document                                                  | `<C-m><C-f>`
| go to test file (based on projectionist config)               | `<leader>a`
| peek definition in popup window                               | `<leader>gh`
| replace word under cursor                                     | `<leader>r`
| replace word under cursor and prefill input with current word | `<leader>R`
| run test under cursor                                         | `<leader>tt`
| run test in opened file                                       | `<leader>tf`
| --- Search ---
| fuzzy search file                                             | `<leader>pp`, `<C-p><C-p>`, `Cmd+p`
| fuzzy search recent file                                      | `<leader>pr`, `<C-p><C-r>`, `Cmd+Shift+a`
| fuzzy search line in file                                     | `<leader>pl`, `<C-p><C-l>`
| fuzzy search text in project                                  | `<leader>pf`, `<C-p><C-f>`, `Cmd+Shift+f`
| fuzzy search text under cursor in project                     | `<leader>fw`
| fuzzy search git changed files                                | `<leader>pg`, `<C-p><C-g>`
| fuzzy search lsp symbols in documents                         | `<leader>ps`,
| --- Tabs ---
| prev tmux pane                                                | `Cmd+Ctrl+[`
| next tmux pane                                                | `Cmd+Ctrl+]`
| prev vim buffer                                               | `Cmd+[`
| next vim buffer                                               | `Cmd+]`
| move vim buffer further                                       | `Cmd+Shift+[`
| move vim buffer back                                          | `Cmd+Shift+]`
| --- Panes ---
| toggle explorer                                               | `<C-k><C-e>`
| toggle undo tree                                              | `<C-k><C-u>`
| toggle search panel                                           | `<C-k><C-f>`
| toggle console                                                | `<C-l><C-n>`
| toggle git blame buffer                                       | `<C-g><C-b>`
| toggle git diff buffer                                        | `<C-g><C-d>`
| --- Edit ---
| add cursor in next word occurrence                            | `C-n`
| skip cursor in matched word                                   | `C-x`
| add cursor above                                              | `M-k`
| add cursor below                                              | `M-j`
| restore last cursors                                          | `\\gS`
| sort selected lines                                           | `<C-m><C-s>`
| break statement into multiple lines                           | `<C-m><C-s>`
| join statement into one line                                  | `<C-m><C-d>`
| break line                                                    | `<leader>j`
| join to previous line                                         | `<leader>k`
| duplicate and comment line                                    | `gj`

#### Manual setup

#### [zinit](https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#install)

#### [neovim](https://github.com/neovim/neovim)

- copy fonts with `bash scripts/copy_fonts.sh`
- setup symlinks with `bash scripts/setup_symlinks.sh`
- [install asdf](https://asdf-vm.com/guide/getting-started.html)
- [install vim-lazy](https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation)
- [install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

#### [tmux](https://github.com/tmux/tmux/wiki)

- install tmux
  ```
  brew install tmux
  ```

#### Other apps

```
brew install neovim reattach-to-user-namespace tmux asdf gnupg coreutils curl git ripgrep git-delta imagemagick wget fontforge
brew install --cask alacritty spectacle slack karabiner-elements whatsapp iterm2 istat-menus spotify contexts steam visual-studio-code monitorcontrol chromedriver tradingview binance
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```

---

#### References

[https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors](https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors)  
[https://pilotmoon.com/scrollreverser/](https://pilotmoon.com/scrollreverser/)  
[alt left / right behavior for iterm2](https://apple.stackexchange.com/questions/136928/using-alt-cmd-right-left-arrow-in-iterm)  
[sync iterm2 with dotfiles](http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)  
[F1-F48 hex codes](http://aperiodic.net/phil/archives/Geekery/term-function-keys.html)
[Ctrl+key hex codes](http://www.physics.udel.edu/~watson/scen103/ascii.html)
