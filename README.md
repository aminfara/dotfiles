# dotfiles

Ali's .files

## Installation

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

ln -s ~/.dotfiles/ghostty $XDG_CONFIG_HOME/ghostty
ln -s ~/.dotfiles/btop $XDG_CONFIG_HOME/btop
ln -s ~/.dotfiles/eza $XDG_CONFIG_HOME/eza
ln -s ~/.dotfiles/lazygit $XDG_CONFIG_HOME/lazygit

# in the new shell, run the install script to install other tools
# open a new terminal and enjoy!
install-cli-tools
```
