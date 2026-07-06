#!/usr/bin/env fish

# install hyprland through pacman
echo "Installing Hyprland ..."
sudo pacman -S --noconfirm --needed \
    hyprland

sudo pacman -S --noconfirm --needed --asdeps \
    hyprpicker wl-clipboard \
    hyprshutdown \
    uwsm libnewt libnotify \
    xdg-desktop-portal-hyprland grim slurp

echo "Installing Noctalia ..."
sudo pacman -S --noconfirm --needed \
    noctalia-shell

sudo pacman -S --noconfirm --needed --asdeps \
    cliphist xdg-utils \
    ddcutil \
    power-profiles-daemon python-gobject \
    wlsunset

# systemctl --user enable --now ssh-agent.socket

# TODO: need fonts

# install papirus icon theme
echo "Installing Papirus icon theme ..."
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh

# Nwg-look qt5ct qt6ct -> save settings for GTK and qt5 and qt6 apps
