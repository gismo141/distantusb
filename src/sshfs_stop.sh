#!/bin/bash
#####
#
# Author: Michael Riedel, 2014
#
# This script removes distant picosafes with sshfs
#
#####

usage()
{
	echo "Usage : sshfs_stop.sh <share_name>"
	echo "                      [<share_name>] (optional)"
	exit
}

stop()
{
	for share_name in "$@"
	do
		echo unmounting $share_name
		fusermount -u /home/picosafe/shares/$share_name
		echo deleting mountpoint $share_name
		rmdir /home/picosafe/shares/$share_name
	done
}

if [ "$#" -lt 1 ]
then
	echo "Parameter missing!"
	usage
else
	stop $@
fi