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

# cd into a dir an run ls
cl ()
{
  if [ -z "$1" ]; then
    ls .
  else
    cd -P -- "$1" &&
    ls .
  fi
}

DEV_BASEPATH=~/code

# Select development environment
# Enable tab completion in .dev-completion.bash
dev ()
{
    cd -P -- "$DEV_BASEPATH"/workspaces/"$1"
}
# Select development environment and python venv
# Enable tab completion in .dev-completion.bash
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
# Enable tab completion in .dev-completion.bash
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
source ~/.dev-completion.bash

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
