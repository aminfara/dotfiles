#!/usr/bin/env fish

# check if the script runs as sudo
if not test -w /
  echo "Please run this script with sudo."
  exit 1
end

# install hyprland through pacman
echo "Installing Hyprland ..."
sudo pacman -S --noconfirm --needed \
    hyprland \

sudo pacman -S --noconfirm --needed --asdeps \
    hyprpicker wl-clipboard \
    hyprshutdown \
    uwsm libnewt libnotify \
    xdg-desktop-portal-hyprland grim slurp \

echo "Installing Noctalia ..."
sudo pacman -S --noconfirm --needed \
    noctalia-shell \

sudo pacman -S --noconfirm --needed --asdeps \
    cliphist xdg-utils \
    ddcutil \
    power-profiles-daemon python-gobject \
    wlsunset \


# TODO: need fonts
