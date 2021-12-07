#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Kdevelop and VSCode"

# VS Code 
apt install -y apt-transport-https software-properties-common wget kdevelop geany 
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt-get update
apt install -y code
