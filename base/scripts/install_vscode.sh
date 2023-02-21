#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install VSCode"

apt-get install -y  wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
apt-get update
apt-get install -y code

sudo -u ${MY_USER} code --install-extension ms-vscode.cpptools
sudo -u ${MY_USER} code --install-extension ms-vscode.cmake-tools
sudo -u ${MY_USER} code --install-extension ms-python.python
sudo -u ${MY_USER} code --install-extension ms-vscode.makefile-tools
#sudo -u ${MY_USER} code --install-extension ms-azuretools.vscode-docker
#sudo -u ${MY_USER} code --install-extension nonanonno.vscode-ros2
#sudo -u ${MY_USER} code --install-extension JaehyunShim.vscode-ros2
#sudo -u ${MY_USER} code --install-extension platformio.platformio-ide
