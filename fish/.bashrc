#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# gpg
export GPG_TTY=$(tty)

# ssh
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# nvim
export EDITOR=nvim

# cache
export CCACHE=sccache

# java home
export JAVA_HOME=/usr/lib/jvm/default-runtime

# libreoffice
export SAL_DISABLE_OPENCL=1

# fish
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]; then 
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
    exec fish $LOGIN_OPTION
fi
