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

# Select development environment, with tab completion
dev ()
{
    source ~/code/venvs/"$1"/bin/activate &&
    cd -P -- ~/code/workspaces/"$1"
}

# Create development environment
mkdev ()
{
    if [ "$1" ]; then
        python3 -m venv ~/code/venvs/"$1" &&
        source ~/code/venvs/"$1"/bin/activate &&
        mkdir ~/code/workspaces/"$1" &&
        cd -P -- ~/code/workspaces/"$1"
    else
        echo "Empty name supplied..."
    fi
}

# Create development environment, checkout things and start vscode
mkdevf ()
{
    if [ "$1" ]; then
        python3 -m venv ~/code/venvs/"$1"
        source ~/code/venvs/"$1"/bin/activate
        mkdir ~/code/workspaces/"$1"
        cd -P -- ~/code/workspaces/"$1"

        git clone "<add git clone address here>"
        # pip install wheel tox # Install specific python packets
        # pip install -e <cloned folder>/ # Install the cloned repo contents in dev mode
        code . # Start vscode
    else
        echo "Empty name supplied..."
    fi
}

# Remove development environment
rmdev ()
{
    cd ~/code/workspaces
    deactivate
    rm -rf ~/code/venvs/"$1"
    rm -rf ~/code/workspaces/"$1"
}

# Add tab completion to dev command
source ~/.dev-completion.bash

# set XON/XOFF active
[[ $- == *i* ]] && stty -ixon


