#!/bin/bash

# usage
usage() {
    echo "usage: $0 [dir] [--no-install | -n] [--extra-deps | -e] [--help | -h]"
    exit
}

# process arguments and options
args=()
inst=true
extra=false
for arg in "$@"; do
  shift
  case "$arg" in
    '--no-install'|'-n')    inst=false ;;
    '--extra-deps'|'-e')    extra=true ;;
    '--help'|'-h')          usage ;;
    '-'*)                   usage ;;
    *)                      args+=($arg) ;;
  esac
done

if [[ ${#args[@]} > 1 ]]; then
    usage
fi

# ---

# dotfile directory
dir=$(pwd)
if [[ ${#args[@]} > 0 ]]; then
	dir=${args[0]}
fi
echo "dotfiles: $dir"

# install packages
install() {
    if $inst; then
        if [ $1 == "-e" ] && $extra; then
            shift
        fi
	    paru -S --needed $@
    fi
}

# backup dir
backup_dir=~/.config/backup
if [ -d $backup_dir ] && [ "$(ls -A $backup_dir)" ]; then
    echo "cleaning backup dir $backup_dir"
    echo "files:"
    ls -1A $backup_dir
    
    read -p "are you sure? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[YySs]$ ]]; then
        rm -rf $backup_dir
    fi
fi

# link
link() {
    if [ -L $2 ]; then
        if [ ! $2 -ef $1 ]; then
            rm $2
        fi
    elif [ -f $2 ] || [ -d $2 ]; then
        mkdir -p $backup_dir
		mv $2 $backup_dir
        echo "backup: $2 to $backup_dir"
	fi

    if [ ! -L $2 ]; then
        ln -sf $1 $2
        echo "link: $2"
    fi
}

# ---

# sway
install swayfx-git swaybg swayidle swaylock-effects-git swaynagmode
link $dir/sway ~/.config/sway

if [ "$EUID" -ne 0 ]; then
    echo "run as root to link environment"
else
    link $dir/sway/environment /etc/environment
fi

# sway utils
install -e autotiling-rs

# login
install -e ly
# TODO: ly config

# wayland utils
install -e pipewire pipewire-pulse wireplumber grim slurp udiskie

# general utils
install -e glow zoxide ripgrep rm-improved eza bat

# rofi
install rofi-lbonn-wayland rofimoji
install -e cliphist
link $dir/rofi ~/.config/rofi
link ~/.cache/wal/config.rasi ~/.config/rofi/config.rasi

# eww
install eww-git
link $dir/eww ~/.config/eww

# foot terminal
install foot
install -e ttf-nerd-fonts-symbols-mono apple-fonts noto-fonts-emoji
link $dir/foot ~/.config/foot

# lf
install lf archivefs perl-file-mimetype
link $dir/lf ~/.config/lf

# fish
install fish fisher direnv
link $dir/fish ~/.config/fish
link $dir/fish/.bashrc ~/.bashrc

# zellij
install -e zellij
link $dir/zellij ~/.config/zellij

# neovim
install neovim fzf
link $dir/nvim ~/.config/nvim

# media
install -e zathura zathura-pdf-poppler mpv imv

# themes
install colloid-icon-theme-git swww

# pandoc
install -e tectonic pandoc-bin
