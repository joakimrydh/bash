#!/usr/bin/env python3

import argparse
import subprocess


def get_workspace_names():
    return subprocess.check_output('gsettings get org.gnome.desktop.wm.preferences workspace-names', shell=True, stderr=subprocess.PIPE, text=True).strip()[1:-1].replace("'", '').split(', ')


def get_workspace_name():
    return get_workspace_names()[get_workspace_index()]


def set_workspace_name(name):
    workspace_names = get_workspace_names()
    current_workspace = get_workspace_index()
    print(f'Changing name from "{workspace_names[current_workspace]}" to "{name}"')
    workspace_names[current_workspace] = name
    subprocess.run(f'gsettings set org.gnome.desktop.wm.preferences workspace-names "{workspace_names}"', shell=True, check=False)


def get_workspace_index():
    return int(subprocess.check_output('xprop -root -notype  _NET_CURRENT_DESKTOP', shell=True, stderr=subprocess.PIPE, text=True).strip().split()[-1])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Show or set the workspace name')
    parser.add_argument('workspace_name', help='New name to set for the current workspace. If "?"- shows the current workspace name.')
    args = parser.parse_args()

    if args.workspace_name == '?':
        print(f'Current workspace is named "{get_workspace_name()}"')
    else:
        set_workspace_name(args.workspace_name)
