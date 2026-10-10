# dotfiles

Ali's .files

## Installation

```shell
# clone this project
git clone https://github.com/aminfara/dotfiles.git ~/.dotfiles

# link zsh (~/.zshenv, ~/.config/zsh) and the Brewfile (~/.config/homebrew)
[[ -f ~/.zshenv ]] && mv -f ~/.zshenv ~/.zshenv.bak
brew install stow
cd ~/.dotfiles && stow zsh homebrew

# install the tools listed in the Brewfile
brew bundle --file ~/.config/homebrew/Brewfile

# start a new zsh session
zsh

# macOS only: fast key repeat
setup-macos-keyboard

ln -s ~/.dotfiles/ghostty $XDG_CONFIG_HOME/ghostty
ln -s ~/.dotfiles/btop $XDG_CONFIG_HOME/btop
ln -s ~/.dotfiles/lazygit $XDG_CONFIG_HOME/lazygit
ln -s ~/.dotfiles/tmux $XDG_CONFIG_HOME/tmux
ln -s ~/.dotfiles/opencode $XDG_CONFIG_HOME/opencode
ln -s ~/.dotfiles/copilot $HOME/.copilot
ln -s ~/.dotfiles/agents $HOME/.agents
ln -s ~/.dotfiles/gitconfig-global $HOME/.gitconfig

# later: update Homebrew and everything in the Brewfile
bruc
```
