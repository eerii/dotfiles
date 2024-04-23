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
