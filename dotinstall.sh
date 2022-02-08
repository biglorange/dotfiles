#!/bin/bash

current_dir=`pwd`
#xinitrc
rm -f ~/.xinitrc
ln -s ${current_dir}/xinitrc ~/.xinitrc
rm -f ~/.xprofile
ln -s ${current_dir}/xprofile ~/.xprofile
rm -f ~/.zprofile
ln -s ${current_dir}/zprofile ~/.zprofile


# zshrc
rm -f ~/.zshrc
ln -s ${current_dir}/zshrc ~/.zshrc
# rm -f ~/.zsh_history
# ln -s ${current_dir}/zsh_history ~/.zsh_history
# i3 config
[ ! -d ~/.config ] && mkdir -p ~/.config/i3
ln -s ${current_dir}/i3/config ~/.config/i3/config
# i3status-rust
ln -s ${current_dir}/i3/i3status_config ~/.config/i3status-rs/config.toml
# dunst
ln -s ${current_dir}/dunst/dunstrc ~/.config/dunst/dunstrc
# gitcofnig
ln -s ${current_dir}/gitconfig ~/.gitconfig
ln -s ${current_dir}/gitignore ~/.gitignore
# aria2
ln -s ${current_dir}/aria2/aria2.conf ~/.aria2/aria2.conf
touch ~/.aria2/aria2.session
# onedrive
ln -s ${current_dir}/onedrive/onedrive_personal/config ~/.config/onedrive/config
ln -s ${current_dir}/onedrive/onedrive_edu/config ~/.config/onedrive_edu/config
# fiqlo
ln -s ${current_dir}/xscreensaver ~/.xscreensaver
# mpv
ln -s ${current_dir}/mpv ~/.config/
# xmodmap
ln -s ${current_dir}/Xmodmap ~/.Xmodmap
# compton/picom
[ ! -d ~/.config/picom ] && mkdir -p ~/.config/picom
ln -s ${current_dir}/i3/picom/picom.conf ~/.config/picom/picom.conf
# paru
[ ! -d ~/.config/paru ] && mkdir -p ~/.config/paru
ln -s ${current_dir}/paru/paru.conf ~/.config/paru/paru.conf
# cargo config
[ ! -d ~/.cargo ] && mkdir -p ~/.cargo
ln -s ${current_dir}/cargo/cargo.conf ~/.cargo/config
