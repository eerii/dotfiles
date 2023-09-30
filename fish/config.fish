if status is-interactive
    # ...
end

if status is-login
    # ...
end

# Abbreviations
abbr -a -- p 'paru'
abbr -a -- pc 'paru -Qtdq | ifne paru -Rns - && paru -Qqd | ifne paru -Rsu -'
abbr -a -- rm 'rip'
abbr -a -- ls 'eza'
abbr -a -- l 'eza -l'
abbr -a -- ga 'git add'
abbr -a --set-cursor -- gc 'git commit -m "%"'
abbr -a -- gc! 'git commit --amend'
abbr -a -- gp 'git push'
abbr -a -- gp! 'git push --force'
abbr -a -- gs 'git status'
abbr -a -- gr 'git rebase'
abbr -a -- grr 'gr! --root'
abbr -a -- sys 'systemctl --user'
abbr -a -- v 'virsh'
abbr -a -- nc 'ncat'

function gr!
    git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE="%cD" git commit --amend --no-edit' rebase -i
end
