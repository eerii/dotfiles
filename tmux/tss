#!/bin/zsh

# Creates or switches to a tmux session
# Based on
#   - the primeagen (https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer/)
#   - carlos becker (https://carlosbecker.com/posts/tmux-sessionizer/)
#   - edward rees (https://edward-rees.com/terminal-tricks/)

# Is tmux running and are we inside a tmux session
is_running=$(ps aux | grep '[t]mux new-session')
if tmux info &> /dev/null; then
    is_inside="true"
fi

# Reads a list of directories from find command and processes them to
# a table for fzf to display, it also prepends all the running tmux sessions
# to the list so they can also be selected, outputs a colored table
tabulate() {
    if [[ $is_inside == "true" ]]; then
        current_session=$(tmux display-message -p '#S')
    fi
    printf "\x1b[32mSession \x1b[32mDirectory \x1b[32mStatus\x1b[0m\n"  #Headings
    # Check the running tasks
    running=$(tmux list-sessions | awk '{print $1}' | sed 's/:$//')

    # Iterate over the directories
    list=$(while IFS=$'\n' read -r line; do
        name="$(basename "$line" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
        dirname="$(echo $line | tr ' ' '·')"
        if [[ $running == *$name* ]]; then
            tmux_status="\x1b[32mrunning\x1b[0m"
        else
            tmux_status="\x1b[33mcreate\x1b[0m"
        fi
        if [[ $name == $current_session ]]; then
            tmux_status="\x1b[31mcurrent\x1b[0m"
        fi
        printf "\x1b[33m$name \x1b[34m$dirname $tmux_status\n"
    done)
    echo $list

    # Add running sessions too
    other_list=$(while IFS=$'\n' read -r rl; do
        if [[ $list == *$rl* ]]; then
            continue
        fi
        echo "\x1b[33m$rl \x1b[34m- \x1b[34mrunning\x1b[0m"
    done <<< $running)
    echo $other_list
}

# Get directory from the first argument
if [[ $# -eq 1 ]]; then
    dir=$1
    name=$(basename "$dir" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
# Get directory from fzf selector
else
    # Use zoxide to get the most used directories and sort them
    dir=$(
        find ~/Uni/* ~/Programacion/* ~/icloud/Programacion/* -maxdepth 0 -type d |
        while read -r p; do
            zoxide query -l -s "$p";
        done |
        sort -rnk1 |
        awk '{$1=""}1' |
        awk '{$1=$1}1'
    )

    # Use tabulate to pretty print into fzf
    dir=$(
        echo $dir |
        tabulate |
        column -t -s' ' |
        fzf-tmux -p 50%,50% --no-sort --header-lines=1 --ansi --reverse --height=100%
    )

    # Clean the output of fzf
    name=$(echo $dir | awk '{print $1}')
    dir=$(echo $dir | awk '{print $2}' | tr '·' ' ')
fi

# If there is no directory dir exit
if [[ -z $dir ]]; then
    exit 0
fi

# If the session is in the Uni directory, append "Practicas" to the directory
if [[ $dir == ~/Uni/* ]]; then
    dir="$dir/Practicas"
fi

# If tmux is not running at all
if [[ -z $TMUX ]] && [[ -z $is_running ]]; then
    tmux new-session -s $name -c $dir
    exit 0
fi

# If tmux is running but does not have a session with that name
# create new session but dont attach
if ! tmux has-session -t=$name 2> /dev/null; then
    tmux new-session -ds $name -c $dir
fi

if [[ $is_inside == true ]]; then
    # Switching from one session to another when already inside tmux
    tmux switch-client -t $name
else
    # If tmux is running, has a session with that name but we are not currently attached
    tmux attach -t $name
fi
