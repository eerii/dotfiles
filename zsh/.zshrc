# New line at the start and after each clear
print ""
function clear() {
    command clear
    print ""
}

# Enable Powerlevel10k instant prompt (should be at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ·········
# Oh My Zsh
# ·········

# Path
export ZSH="$HOME/.oh-my-zsh"

# Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  sudo
  history
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Cache
ZSH_COMPDUMP="$XDG_CACH_HOME/zsh"

# Homebrew Completion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Zoxide fuzzy searcher
eval "$(zoxide init zsh)"

source $ZSH/oh-my-zsh.sh

# ···········
# User Config
# ···········

# PGP
export GPG_TTY=$(tty)export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

# Python
alias python="python3.11"
alias python3="python"
alias pip="pip3.11"
alias pip3="pip"

# Compilers
export SDKROOT="`xcrun --show-sdk-path`"

# Nvim
alias n="nvim"
export EDITOR="nvim"

# Tmux
alias ts="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux list-sessions"
alias td="tmux detach"
bindkey -s '^S' 'tss\n'

# LaTeX
export PATH="/Library/TeX/texbin:$PATH"

# Java
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Postgres
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Git all in one
function G() {
    git add .;
    git commit -m "$1";
    git push;
}

# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# p10k configuration
alias p10k-update="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
