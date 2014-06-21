#!/bin/bash
#####
#
# Author: Michael Riedel, 2014
#
# This script shares the internetconnection between the
# given gateway-interface and the client-interface.
#
#####
mode=$4

usage()
{
	echo "Usage : internetsharing.sh <gateway-interface>"
	echo "                           <client-interface>"
	echo "                           <bridge-to-construct>"
	echo "                           <start/stop>"
	exit
}
start()
{
	gw_interface=$1
	cl_interface=$2
	bridge=$3
	
	echo "Setting up $bridge for $cl_interface..."
	sudo ifconfig $bridge create
	sudo ifconfig $bridge up
	sudo ifconfig $bridge addm $cl_interface

	echo "Setting IP-address and routing $bridge's traffic to $bridge..."
	sudo ifconfig $bridge 172.20.0.1
	sudo route add default -interface $bridge -ifscope $bridge -cloning

	echo "Setting IP-Forwarding and starting NATd..."
	sudo sysctl -w net.inet.ip.forwarding=1
	sudo /sbin/ipfw add 100 divert natd ip from any to any via $gw_interface
	sudo /usr/sbin/natd -interface $gw_interface -use_sockets -same_ports -unregistered_only -dynamic -clamp_mss -enable_natportmap -natportmap_interface $cl_interface

	echo "Done!"
}

stop()
{
	gw_interface=$1
	cl_interface=$2
	bridge=$3
	
	echo "Cleaning up..."
	sudo killall natd
	sudo /sbin/ipfw delete 100 divert natd ip from any to any via $gw_interface
	sudo sysctl -w net.inet.ip.forwarding=0
	sudo ifconfig $gw_interface down
	sudo ifconfig $cl_interface down
	sudo route delete default -interface $bridge -ifscope $bridge
	sudo ifconfig $bridge 172.20.0.1 delete
	sudo ifconfig $bridge deletem $cl_interface
	sudo ifconfig $bridge destroy
	sudo ifconfig $cl_interface up
	sudo ifconfig $gw_interface up

	echo "Done!"
}

if [ "$#" -ne 4 ]
then
	usage
else
	if [ $mode = "start" ]
	then
		start $1 $2 $3
	elif [ $mode = "stop" ]
	then
		stop $1 $2 $3
	else
		echo "Third parameter is wrong! Should I [start/stop]?"
		usage
	fi
fi

