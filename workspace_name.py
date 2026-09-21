#!/usr/bin/env python3

import subprocess
import sys

val = sys.argv[-1]
if len(sys.argv) != 2 or val in ('-h', '--help'):
    print('Usage: wsn new_workspace_name # Set current workspace name.')
    print('       wsn ?                  # Show current workspace name.')
    sys.exit(2)

workspace_names = subprocess.check_output('gsettings get org.gnome.desktop.wm.preferences workspace-names', shell=True, stderr=subprocess.PIPE, text=True).strip()[1:-1].replace("'", '').split(', ')
current_workspace = int(subprocess.check_output('xprop -root -notype  _NET_CURRENT_DESKTOP', shell=True, stderr=subprocess.PIPE, text=True).strip().split()[-1])
if val == '?':
    print(f'Current workspace is named "{workspace_names[current_workspace]}"')
else:
    print(f'Changing name from "{workspace_names[current_workspace]}" to "{val}"')
    workspace_names[current_workspace] = val
    subprocess.run(f'gsettings set org.gnome.desktop.wm.preferences workspace-names "{workspace_names}"', shell=True, check=False)
