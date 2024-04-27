<div align="center">
<h2 align="center">dotfiles</h2>

![](https://img.shields.io/github/last-commit/josekoalas/dotfiles?style=for-the-badge&logo=git&logoColor=white&labelColor=%23191724&color=%23f6c177)
![](https://img.shields.io/github/repo-size/josekoalas/dotfiles?style=for-the-badge&logo=bookstack&logoColor=white&labelColor=%23191724&color=%23c4a7e7)
![](https://img.shields.io/github/issues/josekoalas/dotfiles?style=for-the-badge&logo=bilibili&logoColor=white&labelColor=%23191724&color=%239ccfd8)
</div>

this branch tracks the migration to **nix** 🌙

## todo 📝

- [ ] impermanenece
    - [ ] home directories
    - [ ] backups
- [ ] firefox config
- [ ] neovim config
    - [ ] clone dotfiles
    - [ ] install lsp and formatters
- [ ] development shells

## showcase ✨

![overview](https://github.com/josekoalas/dotfiles/assets/22449369/8437121c-4138-414f-860d-43dc9ab10a85)
![neovim](https://github.com/josekoalas/dotfiles/assets/22449369/c62a8bf6-a2b8-408a-abda-532bea580bb0)

## about 🌿

- **window manager:** [swayfx](https://github.com/WillPower3309/swayfx)
- **launcher:** [rofi (lbonn)](https://github.com/lbonn/rofi)
- **bar:** [waybar](https://github.com/Alexays/Waybar)
- **notifications:** [dunst](https://github.com/dunst-project/dunst)
- **terminal:** [foot](https://codeberg.org/dnkl/foot) + [wezterm](https://github.com/wez/wezterm) 
- **shell:** [fish](https://github.com/fish-shell/fish-shell) + [bash](https://www.gnu.org/software/bash/)
- **editor:** [neovim](https://github.com/neovim/neovim)

## install 🌳

1. clone the repository

```
git clone https://github.com/eerii/dotfiles.git
cd dotfiles
```

2. choose a host from the `host/` folder, or create a new one

```
ls host/
# nyx vm ...
HOST=nyx
```

3. find the disk you want to install to (**it will be deleted!**)

```
lsblk
# /dev/sda ...
DISK=/dev/sda
```

4. run the installation script

```
nix-shell -p just
just install $HOST $DISK
```
