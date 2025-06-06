#/usr/bin/env bash
# This file adds tab completion to dev commands.
# The commands needs to be added to .bashrc and this file needs to be sourced there as well.
# DEV_BASEPATH needs to be set.

function _workspaces()
{
    local cur
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($( compgen -W "$(ls -d $DEV_BASEPATH/workspaces/*/|rev|cut -d "/" -f 2|rev)" -- $cur ) )
}

complete -F _workspaces dev
complete -F _workspaces devv
complete -F _workspaces rmdev
