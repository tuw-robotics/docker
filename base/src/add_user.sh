#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "add user"

apt-get install -y apt-utils sudo bash-completion
groupadd -g ${MY_GID} ${MY_USER}
useradd -m -s /bin/bash  -u ${MY_UID} -g ${MY_GID} ${MY_USER}
export uid=${MY_UID} gid=${MY_GID}
usermod -aG sudo ${MY_USER}
usermod -aG dialout ${MY_USER}
echo "${MY_USER}:${MY_PASSWORD}" | chpasswd

# Optimize bashrc
sed -i 's/HISTSIZE=1000/HISTSIZE=20000/g' ${MY_HOME}/.bashrc  && \
sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=40000/g' ${MY_HOME}/.bashrc

# Remove sudo msg
touch ${MY_HOME}/.sudo_as_admin_successful

chown ${uid}:${gid} -R ${MY_HOME}
