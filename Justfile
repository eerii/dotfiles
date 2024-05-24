# Nix doesn't see files that are not tracked by git, so we check just in case
[private]
check-untracked:
    #!/usr/bin/env sh
    if [[ -n $(git ls-files . --exclude-standard --others) ]]; then
        echo "There are untracked files. Do you want to stage them? (Y/n)"
        read answer
        if [[ $answer != "n" ]] && [[ $answer != "N" ]]; then
            git add .
        fi
    fi

# Deploy the new configuration
switch: check-untracked
    sudo nixos-rebuild switch --flake .

# Deploy the new configuration (but don't activate it until the next reboot)
boot: check-untracked
    sudo nixos-rebuild boot --flake .

# Debug the new configuration
debug: check-untracked
    sudo nixos-rebuild test --flake . --show-trace --verbose
    printf "\033[1;34mThe config was tested but not deployed\nRun \`just switch\` to make it permanent\033[0m\n"

# Check that the flake is correct
check: check-untracked
    nix flake check

# Update all the flake inputs
up:
    nix flake update

# Garbage collect all unused nix store entries
gc:
    sudo nix store gc --debug
    sudo nix-collect-garbage --delete-old
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# List all generations of the system profile
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
repl:
    nix repl -f flake:nixpkgs

# Use nix-inspect to view the contents of a flake
inspect:
    nix-inspect -p $PWD

# Install nixos on a new system
# This will first run disko to create partitions, you need to specify the device where it will be installed
# Then, it will create passwords for the two main users
# Finally, it will install nixos
# Please monitor the progress since the commands will ask for things
install host disk:
    printf "\npartitioning the disk...\n\n"
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/{{host}}/disko.nix --arg sys '{ device = "{{disk}}"; }'
    sudo mkdir /mnt/persist/passwd
    printf "\ncreating root password...\n\n"
    sudo sh -c "mkpasswd > /mnt/persist/passwd/root"
    printf "\ncreating eri password...\n\n"
    sudo sh -c "mkpasswd > /mnt/persist/passwd/eri"
    printf "\ninstalling the system...\n\n"
    sudo cp -r $PWD /mnt/persist/dotfiles
    # sudo chown -R eri /mnt/persist/dotfiles
    sudo nixos-install --root /mnt --flake /mnt/persist/dotfiles#{{host}}
    printf "\ndone c:\n\n"

# Bootstrap the system with secrets after the installation
# You need to provide folders with ssh and gpg keys
postinstall gpg ssh:
    printf "\ncopying ssh keys\n\n"
    mkdir -p ~/.ssh
    cp {{ssh}}/* ~/.ssh
    printf "\nadding public gpg keys\n\n"
    gpg --import {{gpg}}/pub.asc
    printf "\nadding private gpg keys\n\n"
    gpg --batch --import {{gpg}}/sec.asc
