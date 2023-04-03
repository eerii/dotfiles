# Zellij
# eval "$(zellij setup --generate-auto-start zsh)"
alias zj="zellij"
alias zs="zellij --session $1"
alias ze="zellij --layout editor --session $1"
alias zr="zellij run --"
alias zrf="zellij run --floating --"

export ZELLIJ_RUNNER_LAYOUTS_DIR=~/.config/zellij/layouts
export ZELLIJ_RUNNER_BANNERS_DIR=~/.config/zellij/banners
export ZELLIJ_RUNNER_ROOT_DIR=Programacion
export ZELLIJ_RUNNER_MAX_DIRS_DEPTH=3

bindkey -s '' 'zellij-runner\n'

# Plugins
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# Cache
export ZSH_COMPDUMP="$XDG_CACH_HOME/zsh"

# Completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

# Homebrew Completion
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export PATH="/usr/local/sbin:$PATH"

# Zoxide fuzzy searcher
eval "$(zoxide init zsh)"

# Keybinds for zsh history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# PGP
export GPG_TTY=$(tty)export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

# Python
alias python="python3"

# Compilers
export SDKROOT="`xcrun --show-sdk-path`"
export CARGO_TARGET_DIR="./target.nosync"
alias bmake="bear -- make -j 8"

# Neovim
alias n="nvim"
alias nv="neovide --multigrid"
export EDITOR="/usr/local/bin/nvim"

# Unix replacements
alias ls="exa"
alias l='exa -l --all --group-directories-first --git'
alias cat="bat"
alias cd="z"
alias du="dust"
alias find="fd"
alias grep="rg"
alias rm="rip"

# Rclone script
alias rc="~/Programacion/dotfiles/zsh/scripts/rc"

# TLDR man pages
alias tldrf='tldr --list | fzf-tmux -p 80%,80% --height 100% --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

# PATH
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"
export PATH="/Users/jose/.cargo/bin:$PATH"
export PATH="/Users/jose/.local/bin:$PATH"

# LOCALE
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Fix less
export LESSCHARSET="utf-8"

# Git
alias ga='git add'
alias gc='git commit'
alias gc!='git commit --amend'
alias gca='git commit -a -m'
alias gp='git push'
alias gp!='git push --force'
alias gs='git status'
function G {
    git commit -a -m $1;
    git push;
}
alias lg='lazygit'

# Starship prompt
eval "$(starship init zsh)"
source ~/Programacion/dotfiles/zsh/transient.zsh
