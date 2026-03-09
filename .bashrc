## History file setup.
# If in a tmux environment, save history per pane. Basic terminal window hoistory is saved like normal in .bash_history 

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=20000000
if [[ $TMUX_PANE ]]; then
    HISTFILE=$HOME/.bash_history_tmux_${TMUX_PANE:1}
fi
# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND+=("history -a")

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize



## Improved colors. Blue folder names on black sucks.
# Better colors than standard ubuntu
if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
LS_COLORS=$LS_COLORS:'di=0;32:' ; export LS_COLORS

# Make dir and cd into it
mkcd ()
{
  mkdir -p -- "$1" &&
     cd -P -- "$1"
}

# cd into a dir and run ls
cl ()
{
  if [ -z "$1" ]; then
    ls .
  else
    cd -P -- "$1" &&
    ls .
  fi
}

## dev commands
# Enable tab completion in .dev-completion.bash

# Select development environment
dev ()
{
    cd -P -- "$DEV_BASEPATH"/workspaces/"$1"
}
# Select development environment and python venv
devv ()
{
    if [ -f "$DEV_BASEPATH"/venvs/"$1"/bin/activate ]; then
        source "$DEV_BASEPATH"/venvs/"$1"/bin/activate
    fi
    cd -P -- "$DEV_BASEPATH"/workspaces/"$1"
}

# Create development environment
mkdev ()
{
    if [ "$1" ]; then
        mkdir "$DEV_BASEPATH"/workspaces/"$1" &&
        cd -P -- "$DEV_BASEPATH"/workspaces/"$1"
    else
        echo "Empty name supplied..."
    fi
}

# Create development environment and python venv
mkdevv ()
{
    if [ "$1" ]; then
        python3 -m venv "$DEV_BASEPATH"/venvs/"$1" &&
        source "$DEV_BASEPATH"/venvs/"$1"/bin/activate &&
        mkdev "$1"
    else
        echo "Empty name supplied..."
    fi
}

# Remove development environment
rmdev ()
{
    cd "$DEV_BASEPATH"/workspaces
    if [ -d "$DEV_BASEPATH"/venvs/"$1" ]; then
        deactivate &&
        rm -rf "$DEV_BASEPATH"/venvs/"$1"
    fi
    rm -rf "$DEV_BASEPATH"/workspaces/"$1"
}

# Add tab completion to dev command
DEV_BASEPATH=~/code
source ~/.dev-completion.bash

# Open code workspace in this folder or the one above
codew ()
{
    myarray=(`find ./ -maxdepth 1 -name "*.code-workspace"`)
    if [ ${#myarray[@]} -eq 0 ]; then
        myarray=(`find ../ -maxdepth 1 -name "*.code-workspace"`)
    fi
    echo ${myarray}
    code ${myarray[0]}
}
alias cw='codew'

# set XON/XOFF active
[[ $- == *i* ]] && stty -ixon

# Fix password entry for gpg signing over ssh
# sudo update-alternatives --config pinentry
#   select pinentry-curses
# gpg-connect-agent reloadagent /bye
export GPG_TTY=$(tty)

# git aliases
source ~/.git_aliases
gh ()
{
    cat ~/.git_aliases
}

# Better colors for dirs/files with 777.
# Add at end of .bashrc, or at least after "enable color support of ls..."
LS_COLORS="$LS_COLORS:ow=40;36;01"

# Keep secret keys in ~/.bashrc-secrets to stop them from leeking into history.
# They are still saved in clear text, but will not be visible at least...
source ~/.bashrc-secrets
