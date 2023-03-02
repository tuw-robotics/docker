#!/bin/bash

usage() { echo "Usage: $0 [-u <user>] [-h <host>] [-m <mountpoint>] [-s <sharepoint>]" 1>&2; exit 1; }

user=robot
host=r0
sharepoint=./
mountpoint=~/mnt/${host}
while getopts ?u:h:m:s: flag
do
    case "${flag}" in
        u) user=${OPTARG};;
        h) host=${OPTARG};;
        s) sharepoint=${OPTARG};;
        m) mountpoint=${OPTARG};;
        ?) usage;;
        *) usage;;
    esac
done

cmd="sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 ${user}@${host}:${sharepoint} ${mountpoint}"
echo "$cmd"
$cmd
echo "fusermount -u ${MOUNT_POINT}  #to unmount"
