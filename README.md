<div align="center">
<h2 align="center">dotfiles</h2>

![](https://img.shields.io/github/last-commit/josekoalas/dotfiles?style=for-the-badge&logo=git&logoColor=white&labelColor=%23191724&color=%23f6c177)
![](https://img.shields.io/github/repo-size/josekoalas/dotfiles?style=for-the-badge&logo=bookstack&logoColor=white&labelColor=%23191724&color=%23c4a7e7)
![](https://img.shields.io/github/issues/josekoalas/dotfiles?style=for-the-badge&logo=bilibili&logoColor=white&labelColor=%23191724&color=%239ccfd8)
</div>

## showcase ✨

![overview](https://github.com/josekoalas/dotfiles/assets/22449369/8437121c-4138-414f-860d-43dc9ab10a85)
![neovim](https://github.com/josekoalas/dotfiles/assets/22449369/c62a8bf6-a2b8-408a-abda-532bea580bb0)

## about 🌿

- **window manager:** [swayfx](https://github.com/WillPower3309/swayfx)
- **launcher:** [rofi (lbonn)](https://github.com/lbonn/rofi)
- **bar and widgets:** [eww](https://github.com/elkowar/eww)
- **terminal:** [foot](https://codeberg.org/dnkl/foot)
- **shell:** [fish](https://github.com/fish-shell/fish-shell) + [bash](https://www.gnu.org/software/bash/)
- **notifications:** [dunst](https://github.com/dunst-project/dunst)
- **editor:** [neovim](https://github.com/neovim/neovim)

## install 🌳

this works on my machine and is likely to have issues on different systems.
it is recommended to only use as reference.
however, if you wish to install all the configuration, follow these instructions:

1. clone the repo

```sh
git clone https://github.com/josekoalas/dotfiles.git
```

2. (optional) choose a package manager

the installer script can automatically download dependencies.
however, it is made for arch linux in mind.
it is configured to use [paru](https://github.com/Morganamilo/paru), but it may work with other package managers that index the [aur](https://aur.archlinux.org/) such as [yay](https://github.com/Jguer/yay).
you can edit `setup.sh` and change the install command:

```diff
install() {
    if $inst; then
-       paru -S --needed $@
+       <your cmd> $@
    fi
}
```

this will probably not work on other distros since some package names might be different.
for those you should use the `-n` flag to avoid installing dependencies and look into `setup.sh` for a list.

3. run the setup script

```sh
cd dotfiles
./setup.sh
```

if you have already items matching the new configuration on your ~/.config folder it will move them to ~/.config/backup.

## other projects and inspiration 🌺

- .
