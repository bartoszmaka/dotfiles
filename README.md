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

#### [neovim](https://github.com/neovim/neovim)

- copy fonts with `bash scripts/copy_fonts.sh`
- setup symlinks with `bash scripts/setup_symlinks.sh`
- [install vim-packer](https://github.com/wbthomason/packer.nvim)
- [install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- install neovim providers and dependencies

  ```bash
  pip2 install neovim
  pip3 install neovim
  gem install neovim yard
  npm install -g neovim eslint import-js

  brew install the_silver_searcher jq
  # or
  sudo apt install silversearcher_ag jq

  # index ruby project with `yard gems`
  ```

- install plugins with `:PackerSync` (neovim will log errors for the first time)
- install required language servers with `:LspInstall solargraph typescript efm ...`

#### [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)

- install oh my zsh
  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
- place `zshrc` in proper location - `~/.zshrc`
- install plugins, that are not downloaded by default

  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

  ```bash
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  ```

  [alias-tips](https://github.com/djui/alias-tips)

  ```bash
  git clone https://github.com/djui/alias-tips.git $ZSH_CUSTOM/plugins/alias-tips
  ```

  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

  [zsh-z](https://github.com/agkozak/zsh-z)

  ```bash
  https://github.com/agkozak/zsh-z
  ```

#### [tmux](https://github.com/tmux/tmux/wiki)

- install tmux
  ```
  brew install tmux
  ```

#### iTerm2

##### workaround, to get meta key bindings working in vim and tmux

```
preferences > profiles > keys
map
cmd [	send hex 0x20 0x5b
cmd ]	send hex 0x20 0x5d
cmd h	send hex 0x0  0x68
cmd j	send hex 0x0  0x6a
cmd k	send hex 0x0  0x6b
cmd l	send hex 0x0  0x6c
cmd {	send hex 0x0  0x70
cmd }	send hex 0x0  0x6e
# 0x20 - space
# 0x17 - <C-w>
# 0x0  - <C-space>
```

#### Other apps

```
brew cask install spectacle slack flux iterm2
```

---

#### References

[https://github.com/ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher)  
[https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors](https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors)  
[https://pilotmoon.com/scrollreverser/](https://pilotmoon.com/scrollreverser/)  
[alt left / right behavior for iterm2](https://apple.stackexchange.com/questions/136928/using-alt-cmd-right-left-arrow-in-iterm)  
[sync iterm2 with dotfiles](http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/)  
[F1-F48 hex codes](http://aperiodic.net/phil/archives/Geekery/term-function-keys.html)
[Ctrl+key hex codes](http://www.physics.udel.edu/~watson/scen103/ascii.html)
