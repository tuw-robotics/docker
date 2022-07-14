#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install SSH"

# Install libraries/dependencies
RUN apt-get install -y openssh-server

# Allow root user to login over ssh on port 2222
sed -ri 's/^#?Port\s+.*/Port 2222/' /etc/ssh/sshd_config