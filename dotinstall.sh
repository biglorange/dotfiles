#!/bin/bash
#xinitrc
ln -s ~/OneDrive/OS/linux/dotfile/xinitrc ~/.xinitrc
ln -s ~/OneDrive/OS/linux/dotfile/xprofile ~/.xprofile
ln -s ~/OneDrive/OS/linux/dotfile/zprofile ~/.zprofile
ln -s ~/OneDrive/OS/linux/dotfile/zsh_history ~/.zsh_history

# zshrc
ln -s ~/OneDrive/OS/linux/dotfile/zshrc ~/.zshrc
# i3 config
ln -s ~/OneDrive/OS/linux/dotfile/i3/config ~/.config/i3/config
# i3status-rust
ln -s ~/OneDrive/OS/linux/dotfile/i3/i3status_config ~/.config/i3status-rs/config.toml
# dunst
ln -s ~/OneDrive/OS/linux/dotfile/dunst/dunstrc ~/.config/dunst/dunstrc
# gitcofnig
ln -s ~/OneDrive/OS/linux/dotfile/gitconfig ~/.gitconfig
# aria2
ln -s ~/OneDrive/OS/linux/dotfile/aria2/aria2.conf ~/.aria2/aria2.conf
touch ~/.aria2/aria2.session
# onedrive
ln -s ~/OneDrive/OS/linux/dotfile/onedrive/onedrive_personal/config ~/.config/onedrive/config
ln -s ~/OneDrive/OS/linux/dotfile/onedrive/onedrive_edu/config ~/.config/onedrive_edu/config

