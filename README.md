#### basic custom vim shortcuts
![image](https://user-images.githubusercontent.com/12910127/133265699-e045686c-1f9a-4b0e-a155-d3f26913843a.png)

```
  mapping       mode       description

  gd           [NORMAL]    go to definition

  C-p C-p      [NORMAL]    fuzzy search file
  C-p C-r      [NORMAL]    fuzzy search recent file
  C-p C-l      [NORMAL]    fuzzy search line in file
  C-p C-f      [NORMAL]    fuzzy search text in project
  C-p C-g      [NORMAL]    fuzzy search git changed files

  C-k C-e      [NORMAL]    toggle explorer
  C-k C-u      [NORMAL]    toggle undo tree
  C-k C-f      [NORMAL]    toggle search panel

  C-m C-s      [VISUAL]    sort selected lines
  C-m C-f      [NORMAL]    fix document with lsp
  C-m C-s      [NORMAL]    break statement into multiple lines
  C-m C-d      [NORMAL]    join statement into one line
  <leader> j   [NORMAL]    break line
  <leader> k   [NORMAL]    join to previous line

  C-g C-b      [NORMAL]    toggle git blame buffer
  C-g C-d      [NORMAL]    toggle git diff buffer

  C-n          [NORMAL]    add cursor in next word occurrence
  C-x          [CURSOR]    skip cursor in matched word
  M-k          [NORMAL]    add cursor above
  M-j          [NORMAL]    add cursor below

  <leader> f   [NORMAL]    open search prompt
  <leader> r   [NORMAL]    replace current word
  <leader> r   [VISUAL]    replace selected pattern
  <leader> a   [VISUAL]    go to test file (based on projectionist config)

  <leader> t t [NORMAL]    run test under cursor
  <leader> t f [NORMAL]    run test in opened file
```

#### Manual setup
#### [neovim](https://github.com/neovim/neovim)
- copy fonts with `bash scripts/copy_fonts.sh`
- setup symlinks with `bash scripts/setup_symlinks.sh`
- [install vim-packer](https://github.com/wbthomason/packer.nvim)
- [install neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- install neovim providers and dependencies
  ``` bash
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
  ``` bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
- place `zshrc` in proper location - `~/.zshrc`
- install plugins, that are not downloaded by default

  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  
  ``` bash
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  ```
  
  [alias-tips](https://github.com/djui/alias-tips)
  
  ``` bash
  git clone https://github.com/djui/alias-tips.git $ZSH_CUSTOM/plugins/alias-tips
  ```
  
  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  
  ``` bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

  [zsh-z](https://github.com/agkozak/zsh-z)

  ``` bash
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
