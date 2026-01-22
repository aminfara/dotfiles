My ZSH setup and configuration files.

Sets up ZSH goodies, brew, misenplace, and more.

Based on Antidote example at https://github.com/getantidote/zdotdir/tree/main

```shell
# clone this project
git clone https://github.com/aminfara/dotfiles.git ~/.dotfiles

ZDOTDIR=~/.config/zsh
ln -s ~/.dotfiles/zsh $ZDOTDIR

# source the .zshenv from ZDOTDIR
[[ -f ~/.zshenv ]] && mv -f ~/.zshenv ~/.zshenv.bak
echo ". $ZDOTDIR/.zshenv" > ~/.zshenv

# start a new zsh session
zsh

# in the new shell, run the install script to install other tools
# open a new terminal and enjoy!
install-cli-tools
```
