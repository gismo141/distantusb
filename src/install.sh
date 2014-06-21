#!/bin/bash
#####
#
# Author: Michael Riedel, 2014
#
# This script installs all important programs and its dependencies for Distant-USB:
#   sshfs, samba, smbfs, avahi-daemon, avahi-utils and expect
# and configures them as needed.
#
# usage: ./install.sh
#
#####
wget -q --tries=10 --timeout=20 http://google.com
if [[ $? -eq 0 ]]; then
	echo "Changing owner of all files and subfolders in this folder ..."
	sudo chown -R picosafe *
	sudo chgrp -R picosafe *
	echo "Configuring apt-get for beeing quiet this time ..."
	export DEBIAN_FRONTEND=noninteractive
	echo "Updating repositories ..."
	sudo apt-get update
	echo "Installing sshfs ..."
	sudo apt-get -q -y install sshfs
	echo "Adding and configuring the FUSE-device ..."
	# determine later which one of these does the trick
	sudo addgroup picosafe fuse
	sudo usermod -aG fuse picosafe
	sudo sh -c 'echo "fuse" >> /etc/modules'
	sudo chmod +x /usr/bin/fusermount
	sudo mknod /dev/fuse c 10 229
	sudo chown picosafe:picosafe /dev/fuse
	sudo sed -i.bak 's/#user_allow_other/user_allow_other/g' /etc/fuse.conf
	echo "Creating share-structure ..."
	mkdir -m 777 /home/picosafe/shares
	mkdir -m 777 /home/picosafe/myPicosafe
	echo "Installing Samba ..."
	sudo apt-get -q -y install samba smbfs
	echo "Configuring Samba ..."
	sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
	sudo chown root:root smb.conf
	sudo cp smb.conf /etc/samba/smb.conf
	echo "Installing Avahi ..."
	sudo apt-get -q -y install avahi-daemon avahi-utils
	echo "Configuring Avahi ..."
	sudo mv smb.service /etc/avahi/services/smb.service
	echo "Setting up the webinterface for Distant-USB ..."
	sudo mkdir /opt/picosafe/webinterface/distantusb
	sudo cp -r distantusb_webinterface/. /opt/picosafe/webinterface/distantusb
	sudo chown -R picosafe:picosafe /opt/picosafe/webinterface/distantusb/
	sudo cp sshfs_start.sh /usr/bin/sshfs_start.sh
	sudo cp sshfs_stop.sh /usr/bin/sshfs_stop.sh
	echo "Generating SSH-keys with empty passphrase ..."
	ssh-keygen -t rsa -N "" -f /home/picosafe/.ssh/id_rsa
	echo "Installing expect for automated terminal interaction ..."
	sudo apt-get -q -y install expect
	sudo cp copy_keys.sh /usr/bin/copy_keys.sh
	echo -e "\n\nEverything is installed.\nRebooting your picosafe to finalize the the setup.\n\nYou need to decrypt your picosafe with the webinterface after the reboot."
	sudo shutdown -r now
else
	echo "You seem to be disconnected from the internet. If your host is on Mac OSX, share the internet-connection with the script 'internetsharing.sh'! Otherwise share the networkconnection accordingly to your operating system."
fi 