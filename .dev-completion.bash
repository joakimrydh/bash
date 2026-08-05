#/usr/bin/env bash
# This file adds tab completion to dev commands.
# The commands needs to be added to .bashrc and this file needs to be sourced there as well.
# DEV_BASEPATH needs to be set.

function _workspaces()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ -n "$(ls -d $DEV_BASEPATH/workspaces/*/ 2>/dev/null)" ]; then
        COMPREPLY=($( compgen -W "$(ls -d $DEV_BASEPATH/workspaces/*/|rev|cut -d "/" -f 2|rev)" -- $cur ) )
    else
        echo "Error: No projects to select"
        COMPREPLY=()
    fi
}
complete -F _workspaces dev
complete -F _workspaces devr
complete -F _workspaces rmdev

function _venv_workspaces()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ -n "$(ls -d $DEV_BASEPATH/venvs/*/ 2>/dev/null)" ]; then
        COMPREPLY=($( compgen -W "$(ls -d $DEV_BASEPATH/venvs/*/|rev|cut -d "/" -f 2|rev)" -- $cur ) )
    else
        echo "Error: No projects with venvs to select"
        COMPREPLY=()
    fi
}
complete -F _venv_workspaces devv
