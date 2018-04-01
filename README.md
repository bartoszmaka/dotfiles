#### TL;DR (requires curl)
``` bash
curl https://raw.githubusercontent.com/bartoszmaka/dotfiles/master/postinstall.sh | bash
```
or (requires git)
``` bash
git clone https://github.com/bartoszmaka/dotfiles ~/.repos/dotfiles
cd ~/.repos/dotfiles
bash postinstall.sh
```

---

#### References

[https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors](https://askubuntu.com/questions/141752/keyboard-shortcut-to-move-windows-between-monitors)

---

#### [Vim-Plug](https://github.com/junegunn/vim-plug)

``` bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs /
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs /
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

#### neovim plugins dependencies

[https://github.com/ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher)  
[https://github.com/universal-ctags/ctags](https://github.com/universal-ctags/ctags)  
[https://github.com/uptech/alt](https://github.com/uptech/alt)  

---

#### Config files proper location

``` bash
~/.config/redshift.conf  
~/.config/alacritty/alacritty.yml  
~/.imwheelrc  
~/.vimrc  
~/.tmux.conf  
~/.zshrc  
~/.rubocop.yml  
~/.tmux/plugins/tmux-powerline/themes/default.sh (after installing tmux-powerline plugin)  
```

---

### Things that require manual installation


#### [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) plugins

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
#### ppa repositories you might want to add

``` bash
sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
``````

### Debug

---

#### check if console supports 24bit - truecolor
`bash testcase-truecolors.sh`  

----

### Common bugs

#### Low cpu frequency after suspending laptop
###### (dell latitude e6430 / i5-3320m)

#### diagnosis
``` bash
watch -n 1 -d "cat /proc/cpuinfo | grep -i Mhz"
```
shows too low frequency (less than 1200 for my cpu)
``` bash
sudo modprobe msr
sudo rdmsr -a 0x19a
```
returns something other than `0`

##### temporary solution:
you have to set register `0x19a` to `0` with `wrmsr -a 0x19a 0x0`  

##### permanent solution:

``` bash
sudo cp 10_fix_low_cpu_frequency /lib/systemd/system-sleep/
sudo chmod +x /lib/systemd/system-sleep/10_fix_low_cpu_frequency
sudo echo 'msr' >> /etc/modules
```

#### Fix mouse wheel scrolling speed systemwide
``` bash
sudo apt-get install imwheel
```

add following lines to `~/.imwheelrc'` or clone from this repo
``` bash
".*"
None,      Up,   Button4, 3
None,      Down, Button5, 3
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
```
execute on autostart
``` bash
imwheel --kill --buttons "4 5"
```
