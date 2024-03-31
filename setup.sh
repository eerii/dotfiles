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
    ROOT=""
    if [[ $3 == "--root" ]]; then
        ROOT="sudo"
    fi
    if [ -L $2 ]; then
        if [ ! $2 -ef $1 ]; then
            $ROOT rm $2
        fi
    elif [ -f $2 ] || [ -d $2 ]; then
        $ROOT mkdir -p $backup_dir
		$ROOT mv $2 $backup_dir
        echo "backup: $2 to $backup_dir"
	fi

    if [ ! -L $2 ]; then
        $ROOT ln -sf $1 $2
        echo "link: $2"
    fi
}

# ---

# sway
install swayfx-git swayidle swaylock-effects-git swaynagmode
link $dir/sway ~/.config/sway

link $dir/sway/environment /etc/environment --root

# sway utils
install -e autotiling-rs pipewire pipewire-pulse wireplumber \
    brightnessctl grim slurp swappy udiskie cliphist hyprpicker

# general utils
install -e zoxide ripgrep rm-improved eza bat dust fd rsync

# rofi
install rofi-lbonn-wayland rofimoji
install -e cliphist
link $dir/rofi ~/.config/rofi
link ~/.cache/wal/config.rasi ~/.config/rofi/config.rasi

# waybar
install waybar power-profiles-daemon
link $dir/waybar ~/.config/waybar

# terminals
install foot wezterm
install -e ttf-nerd-fonts-symbols-mono apple-fonts noto-fonts-emoji
link $dir/foot ~/.config/foot
link $dir/wezterm ~/.config/wezterm

# fish and bash
install fish fisher direnv
link $dir/fish ~/.config/fish
link $dir/fish/.bashrc ~/.bashrc

# neovim
install neovim-nightly-bin fzf
link $dir/nvim ~/.config/nvim

# lf
install lf archivefs perl-file-mimeinfo
link $dir/lf ~/.config/lf

# media
install -e zathura zathura-pdf-poppler celluloid imv localsend-bin easyeffects

# web and mail
install -e firefox firefox-ublock-origin thunderbird

# themes
install colloid-icon-theme-git swww adwaita-qt4 adwaita-qt5-git adwaita-qt6-git

# pandoc
install -e tectonic pandoc-bin
