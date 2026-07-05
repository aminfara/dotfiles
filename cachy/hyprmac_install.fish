#!/usr/bin/env fish

# install hyprland through pacman
echo "Installing Hyprland ..."
sudo pacman -S --noconfirm --needed \
    hyprland

sudo pacman -S --noconfirm --needed --asdeps \
    hyprpicker wl-clipboard \
    hyprshutdown \
    polkit-kde-agent \
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

systemctl --user enable --now ssh-agent.socket

# TODO: need fonts
