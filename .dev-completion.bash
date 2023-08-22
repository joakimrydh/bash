#/usr/bin/env bash
# This file adds tab completion to dev and rmdev commands. These commands needs to be added to .bashrc and this file needs to be sourced there as well.

function _workspaces()
{
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($( compgen -W "$(ls -d ~/code/workspaces/*/|cut -d "/" -f 6)" -- $cur ) )
}

complete -F _workspaces dev
complete -F _workspaces rmdev
