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

# Select development environment
# Enable tab completion in .dev-completion.bash
dev ()
{
    source ~/code/venvs/"$1"/bin/activate &&
    cd -P -- ~/code/workspaces/"$1"
}
# Select development environment and python venv
# Enable tab completion in .dev-completion.bash
devv ()
{
    source ~/code/venvs/"$1"/bin/activate &&
    cd -P -- ~/code/workspaces/"$1"
}

# Create development environment
mkdev ()
{
    if [ "$1" ]; then
        mkdir ~/code/workspaces/"$1" &&
        cd -P -- ~/code/workspaces/"$1"
    else
        echo "Empty name supplied..."
    fi
}

# Create development environment and python venv
mkdevv ()
{
    if [ "$1" ]; then
        python3 -m venv ~/code/venvs/"$1" &&
        source ~/code/venvs/"$1"/bin/activate &&
        mkdev "$1"
    else
        echo "Empty name supplied..."
    fi
}

# Remove development environment
# Enable tab completion in .dev-completion.bash
rmdev ()
{
    cd ~/code/workspaces
    if [ -d ~/code/venvs/"$1" ]; then
        deactivate &&
        rm -rf ~/code/venvs/"$1"
    fi
    rm -rf ~/code/workspaces/"$1"
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

