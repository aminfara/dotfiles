function setup_fonts_and_keyboard
  echo "▸ Installing nerd fonts…"
  brew install font-hack-nerd-font font-symbols-only-nerd-font

  echo "▸ Setting key repeat rate…"
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
end
