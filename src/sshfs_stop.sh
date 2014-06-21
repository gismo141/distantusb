#!/bin/bash
#####
#
# Author: Michael Riedel, 2014
#
# This script unmounts distant picosafes from sshfs
#
# usage: ./sshfs_start.sh <share_name> [<share_name>]
#
#####
for ARG in "$@"
do
	# split arguments in share_name and user_host
	share_name=${ARG%,*}
	user_host=${ARG#*,}
	
	# now do the magic
	echo unmounting $share_name
	fusermount -u /home/picosafe/shares/$share_name
	echo deleting mountpoint $share_name
	rmdir /home/picosafe/shares/$share_name
done
