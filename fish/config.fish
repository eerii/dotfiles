if status is-interactive
    # ...
end

if status is-login
    # ...
end

# Abbreviations
abbr -a --set-cursor -- b "b '%'"
abbr -a -- ba 'bash'
abbr -a -- p 'paru'
abbr -a -- pd 'paru --asdeps -S' # install only temporary
abbr -a -- pdc 'pd && /usr/bin/fish && pc' # make function that takes arguments
abbr -a -- pc 'paru -Qtdq | ifne paru -Rns - && paru -Qqd | ifne paru -Rsu -'
abbr -a -- pcc 'pc && paru -Sccd'
abbr -a -- pu 'paru -Syu'
abbr -a -- rc 'cargo sweep -r -t 30 /'
abbr -a -- ru 'rustup update && cargo sweep -ri /'
abbr -a -- rm 'rip'
abbr -a -- RM '/bin/rm -rf'
abbr -a -- ls 'eza'
abbr -a -- grep 'rg'
abbr -a -- cat 'bat -p'
abbr -a -- l 'lfcd'
abbr -a -- ga 'git add'
abbr -a --set-cursor -- gc 'git commit -m "%"'
abbr -a -- gc! 'git commit --amend'
abbr -a -- gd 'git diff'
abbr -a -- gp 'git push'
abbr -a -- gp! 'git push --force'
abbr -a -- gs 'git status'
abbr -a -- gr 'git rebase'
abbr -a -- grr 'gr! --root'
abbr -a -- gfomo 'git fetch upstream main && git rebase upstream/main --autostash'
abbr -a -- gsa 'git stash'
abbr -a -- gsp 'git stash pop'
abbr -a -- sys 'systemctl --user'
abbr -a -- nc 'ncat'
abbr -a -- grdl 'gradle -q --console plain run'
abbr -a -- nv 'neovide && exit'
abbr -a -- todo 'rg TODO -NI --trim | sed "s/.*TODO:/- [ ]/"'

function gr!
    git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE="%cD" git commit --amend --no-edit' rebase -i
end

# Keybinds
function launch_zellij
    if not set -q ZELLIJ
        command zellij
        commandline -f repaint
    end
end

function fish_user_key_bindings
    bind \ca launch_zellij
end

function b
    set -l cmd (string join " " $argv)
    set cmd (string replace --all '\;' ';' $cmd)
    bash -c "$cmd"
end

# lf
function lfcd
    set tmp (mktemp)
    set fid (mktemp)
    command lf -command '$printf $id > '"$fid"'' -last-dir-path=$tmp $argv
    set id (cat "$fid")
    set mount_dir "/tmp/__lf_mount_$id"
    if test -f "$mount_dir"
        cat $mount_dir | \
            while read -l line
                umount "$line"
                rmdir "$line"
            end
        rm -f "$mount_dir"
    end
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

# Direnv
direnv hook fish | source
