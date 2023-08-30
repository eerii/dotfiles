#!/bin/bash

# usage
usage() {
    echo "usage: $0 [dir] [--hypr] [--help | -h]"
    exit
}

# process arguments and options
args=()
hypr=false
for arg in "$@"; do
  shift
  case "$arg" in
    '--hypr')       hypr=true ;;
    '--help'|'-h')  usage ;;
    '-'*)           usage ;;
    *)              args+=($arg) ;;
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
	paru -S --needed $@
}

# backup dir
rm -rf ~/.config/backup > /dev/null 2>&1
mkdir -p ~/.config/backup
backup() {
	if [ -L $1 ] || [ -f $1 ]; then
		rm -f $1
	elif [ -d $1 ]; then
		mv $1 ~/.config/backup
	fi
}

# link
link() {
    backup $2
    ln -sf $1 $2
}

# ---

# hyprland
if $hypr; then
    install hyprland-git xdg-desktop-portal-hyprland-git \
        pipewire pipewire-pulse wireplumber \
        grim slurp dunst udiskie
    link $dir/hypr ~/.config/hypr

    # rofi
    install rofi-lbonn-wayland
    link $dir/rofi ~/.config/rofi
fi

# wezterm
install wezterm ttf-nerd-fonts-symbols-mono otf-apple-fonts noto-fonts-emoji
link $dir/wezterm ~/.config/wezterm

# fish
install fish
link $dir/fish ~/.config/fish
link $dir/fish/.bashrc ~/.bashrc

# neovim
install neovim fzf
link $dir/nvim ~/.config/nvim
