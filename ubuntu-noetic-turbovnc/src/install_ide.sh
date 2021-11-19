#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Kdevelop and VSCode"

# VS Code 
apt install -y apt-transport-https software-properties-common wget 
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
echo "1 Install Kdevelop and VSCode"
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
echo "2 Install Kdevelop and VSCode"
apt-get update
echo "3 Install Kdevelop and VSCode"
apt install code
