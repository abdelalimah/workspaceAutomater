## workspace automater is a command line tool for creating workspaces assembling multiple apps to run with a single command (for macOs)
# Usage

## Setup : copy and past the following command in your terminal

git clone https://github.com/abdelalimah/Workspace-Automater.git && sudo bash workspaceAutomater/automater.sh setup && cd && rm -rf workspaceAutomater

## Creating a workspace
automater create workspace_name app1_name app1_name ...

## Launching a workspace
automater start workspace_name

## Closing a workspace(on upcoming release)
automater close workspace_name

## Deleting a workspace(on upcoming release)
automater delete workspace_name
##
to edit or delete a workspace please refer to /.automater_workspaces on your root directory and modify it with your favorite text editor
##
Enjoy 🦊.
