function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    set_color -o
    echo -n (set_color purple)(path basename -- $PWD)

    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color 444 brblack)': '
    set_color normal
end
