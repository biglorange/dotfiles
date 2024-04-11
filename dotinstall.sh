#!/bin/bash

function link_file_after_delete()
{
    file_path=$1
    link_file=$2

    if [ -f "link_file" ]; then
        rm -f "link_file"
    fi

    if [ -f "$file_path" ]; then
        ln -s "$file_path" "$link_file"
    fi
}

function chk_path_mk()
{
    file_path=$1
    if [ ! -d "$file_path" ]; then
        mkdir -p "$file_path"
    fi
}

current_dir=$(pwd)
#xinitrc
link_file_after_delete "${current_dir}/xinitrc" "${HOME}/.xinitrc"
link_file_after_delete "${current_dir}/xprofile" "${HOME}/.xprofile"
link_file_after_delete "${current_dir}/zprofile" "${HOME}/.zprofile"

# zshrc
link_file_after_delete "${current_dir}/zshrc" "${HOME}/.zshrc"
link_file_after_delete "${current_dir}/zshrc_ext" "${HOME}/.zshrc_ext"

# i3 config
chk_path_mk "${HOME}/.config/i3"
link_file_after_delete "${current_dir}/i3/config" "${HOME}/.config/i3/config"

# i3status-rust
chk_path_mk "${HOME}/.config/i3status-rs"
link_file_after_delete "${current_dir}/i3/i3status_config" "${HOME}/.config/i3status-rs/config.toml"

# dunst
chk_path_mk "${HOME}/.config/dunst"
link_file_after_delete "${current_dir}/dunst/dunstrc" "${HOME}/.config/dunst/dunstrc"

# gitcofnig
link_file_after_delete "${current_dir}/gitconfig" "${HOME}/.gitconfig"
link_file_after_delete "${current_dir}/gitignore" "${HOME}/.gitignore"
link_file_after_delete "${current_dir}/git/gitconfig_ext" "${HOME}/.gitconfig_ext"
# aria2
chk_path_mk "${HOME}/.config/.aria2"
link_file_after_delete ${current_dir}/aria2/aria2.conf ${HOME}/.aria2/aria2.conf
touch "${HOME}/.aria2/aria2.session"

# onedrive
chk_path_mk "${HOME}/.config/onedrive"
link_file_after_delete "${current_dir}/onedrive/onedrive_personal/config" "${HOME}/.config/onedrive/config"
# link_file_after_delete ${current_dir}/onedrive/onedrive_edu/config ${HOME}/.config/onedrive_edu/config
# fiqlo
link_file_after_delete "${current_dir}/xscreensaver" "${HOME}/.xscreensaver"
# mpv
rm -rf "${HOME}/.config/mpv"
link_file_after_delete "${current_dir}/mpv" "${HOME}/.config/"
# xmodmap
link_file_after_delete "${current_dir}/Xmodmap" "${HOME}/.Xmodmap"
# compton/picom
chk_path_mk "${HOME}/.config/picom"
link_file_after_delete "${current_dir}/i3/picom/picom.conf" "${HOME}/.config/picom/picom.conf"
# paru
chk_path_mk "${HOME}/.config/paru"
link_file_after_delete "${current_dir}/paru/paru.conf" "${HOME}/.config/paru/paru.conf"
# cargo config
chk_path_mk "${HOME}/.cargo"
link_file_after_delete "${current_dir}/cargo/cargo.conf" "${HOME}/.cargo/config"

sudo rm -f /etc/pacman.conf
sudo ln -s "${current_dir}/pacman/pacman.conf" "/etc/pacman.conf"

sudo rm -f /etc/pacman.d/mirrorlist
sudo ln -s "${current_dir}/pacman/pacman.d/mirrorlist" "/etc/pacman.d/mirrorlist"

sudo rm -f /etc/pacman.d/hooks
sudo ln -s "${current_dir}/pacman/pacman.d/hooks" "/etc/pacman.d/hooks"

link_file_after_delete "${current_dir}/npm/npmrc" "${HOME}/.npmrc"
