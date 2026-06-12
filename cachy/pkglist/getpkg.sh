#!/bin/bash

EXP_FILE=explicitly_installed_packages.txt
OPT_FILE=optional_packages_installed_asdeps.txt


echo "Exporting list of explicitly installed packages to '$EXP_FILE'..."
pacman -Qqe > "$EXP_FILE"

echo "Exporting list of optional packages installed (asdeps) to '$OPT_FILE' ..."
comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > "$OPT_FILE"
