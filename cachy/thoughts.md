# Hyprland Setup for CachyOS

## Prerequisites

### Brew

```shell
sudo pacman -S base-devel procps-ng curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### Stow

```shell
brew install stow
```

### My dotfiles

```shell
git clone git@github.com:aminafar/dotfiles.git .dotfiles
cd ~/.dotfiles
stow -v -t ~ fish
cd ~/.dotfiles/cachy
stow -v -t ~ hyprland
```

## Install Hyprland and related software

### Pakcages needed for Hyprland

```shell
sudo pacman -S --needed --asdeps qt5-wayland qt6-wayland noto-fonts kvantum kvantum-qt5 nwg-look qt5ct qt6ct
sudo pacman -S --needed wl-clipboard ghostty
```

### Hyprland

```shell
sudo pacman -Sy --asdeps --needed cmake cpio glaze hyprland-protocols hyprshutdown meson uwsm
sudo pacman -Sy --needed hyprland
```

Hyprland Env vars are set in both uwsm/env and hyprland.lua

### XDPH + deps for screenshot

```shell
sudo pacman -Sy --asdeps --needed grim slurp swappy otf-font-awesome
sudo pacman -Sy --needed xdg-desktop-portal-hyprland
```

### Agent (Prompts for password when needed, e.g. for sudo)

```shell
sudo pacman -Sy --needed hyprpolkitagent
```

### Noctalia

```shell
sudo pacman -Sy --asdeps --needed cliphist wlsunset ddcutil qt6-quick3d
paru -S --needed noctalia-shell
```

Noctalia also handles the wallpaper, notifications and launcher.

### Filemanager

```shell
sudo pacman -Sy --asdeps --needed catfish gvfs tumbler thunar-volman thunar-archive-plugin thunar-media-tags-plugin
sudo pacman -Sy thunar
```

### Colorpicker

```shell
sudo pacman -Sy --needed hyprpicker
```

### SDDM

```shell
sudo pacman -Sy --needed sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
paru -S --needed sddm-astronaut-theme
printf '%s\n' '[Theme]' 'Current=sddm-astronaut-theme' | sudo tee /etc/sddm.conf > /dev/null
systemctl enable sddm.service
```

reboot and enjoy your new Hyprland setup!
