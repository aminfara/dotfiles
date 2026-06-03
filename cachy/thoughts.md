Need to install ghostty and zsh/fish by non-brew

no gpg from brew

sudo pacman -S wl-clipboard

hyprland

```
sudo pacman -Sy --asdeps --needed cmake cpio glaze hyprland-protocols hyprshutdown meson uwsm xdg-desktop-portal-hyprland

sudo pacman -Sy --needed hyprland
```

xdg-desktop-portal-hyprland + deps for screenshot

```
sudo pacman -Sy --asdeps --needed grim slurp swappy
sudo pacman -Sy --needed xdg-desktop-portal-hyprland

```

agent

```

sudo pacman -Sy --needed hyprpolkitagent
```

notification

handled by noctalia

wallpaper

handled by noctalia

launcher

handled by noctalia

filemanager

```
sudo pacman -Sy --asdeps --needed catfish gvfs tumbler thunar-volman thunar-archive-plugin thunar-media-tags-plugin
sudo pacman -Sy thunar
```

noctalia

```
sudo pacman -Sy --asdeps --needed cliphist wlsunset
paru -S noctalia-shell

```

sudo pacman -Sy --needed qt5-wayland qt6-wayland noto-fonts

```

```

Hyprland Strongly required software

```

```

Colorpicker
sudo pacman -Sy --needed hyprpicker

hyprland Env vars are set in both uwsm/env and hyprland.lua
