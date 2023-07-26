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
[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.config/i3 ] && mkdir -p ~/.config/i3
rm -f ~/.config/i3/config
ln -s ${current_dir}/i3/config ~/.config/i3/config
# i3status-rust
[ ! -d ~/.config/i3status-rs ] && mkdir -p ~/.config/i3status-rs
rm -f ~/.config/i3status-rs/config.toml
ln -s ${current_dir}/i3/i3status_config ~/.config/i3status-rs/config.toml
# dunst
[ ! -d ~/.config/dunst ] && mkdir -p ~/.config/dunst
rm -f ~/.config/dunst/dunstrc
ln -s ${current_dir}/dunst/dunstrc ~/.config/dunst/dunstrc
# gitcofnig
rm -f ~/.gitconfig
rm -f ~/.gitignore
ln -s ${current_dir}/gitconfig ~/.gitconfig
ln -s ${current_dir}/gitignore ~/.gitignore
# aria2
[ ! -d ~/.config/.aria2 ] && mkdir -p ~/.config/.aria2
rm -f ~/.aria2/aria2.conf
ln -s ${current_dir}/aria2/aria2.conf ~/.aria2/aria2.conf
touch ~/.aria2/aria2.session
# onedrive
[ ! -d ~/.config/onedrive ] && mkdir -p ~/.config/onedrive
rm -f ~/.config/onedrive/config
ln -s ${current_dir}/onedrive/onedrive_personal/config ~/.config/onedrive/config
# ln -s ${current_dir}/onedrive/onedrive_edu/config ~/.config/onedrive_edu/config
# fiqlo
rm -f ~/.xscreensaver
ln -s ${current_dir}/xscreensaver ~/.xscreensaver
# mpv
rm -rf ~/.config/mpv
ln -s ${current_dir}/mpv ~/.config/
# xmodmap
rm -f ~/.Xmodmap
ln -s ${current_dir}/Xmodmap ~/.Xmodmap
# compton/picom
[ ! -d ~/.config/picom ] && mkdir -p ~/.config/picom
rm -f ~/.config/picom/picom.conf
ln -s ${current_dir}/i3/picom/picom.conf ~/.config/picom/picom.conf
# paru
[ ! -d ~/.config/paru ] && mkdir -p ~/.config/paru
rm -f ~/.config/paru/paru.conf
ln -s ${current_dir}/paru/paru.conf ~/.config/paru/paru.conf
# cargo config
[ ! -d ~/.cargo ] && mkdir -p ~/.cargo
rm -f ~/.cargo/config
ln -s ${current_dir}/cargo/cargo.conf ~/.cargo/config

rm -f /etc/pacman.conf
sudo ln -s ${current_dir}/pacman/pacman.conf /etc/pacman.conf

rm -f /etc/pacman.d/mirrorlist
sudo ln -s ${current_dir}/pacman/pacman.d/mirrorlist /etc/pacman.d/mirrorlist

sudo ln -s ${current_dir}/pacman/pacman.d/hooks /etc/pacman.d/hooks
