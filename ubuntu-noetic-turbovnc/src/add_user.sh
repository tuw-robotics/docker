#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "add user"

apt-get install -y apt-utils sudo bash-completion
groupadd -g ${MY_GID} ${MY_USER}
useradd -m -s /bin/bash  -u ${MY_UID} -g ${MY_GID} ${MY_USER}
export uid=${MY_UID} gid=${MY_GID}
usermod -aG sudo ${MY_USER}
chown ${uid}:${gid} -R ${MY_HOME}
echo "${MY_USER}:${MY_PASSWORD}" | chpasswd
