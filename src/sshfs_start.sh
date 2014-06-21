#!/bin/bash
#####
#
# Author: Michael Riedel, 2014
#
# This script mounts distant picosafes with sshfs
#
#####

usage()
{
	echo "sshfs_start.sh <share_name>,<user>@<host>"
	echo "              [<share_name>,<user>@<host>] (optional)"
	exit
}

start()
{
	for ARG in "$@"
	do
		# split arguments in share_name and user_host
		share_name=${ARG%,*}
		user_host=${ARG#*,}
		
		# now do the magic
		echo creating share $share_name
		mkdir -m 777 /home/picosafe/shares/$share_name
		echo mounting $share_name
		sshfs $user_host:/home/picosafe/myPicosafe /home/picosafe/shares/$share_name/ -o allow_other,auto_cache,reconnect
	done
}

if [ "$#" -lt 1 ]
then
	echo "Parameter missing!"
	usage
else
	start $@
fi