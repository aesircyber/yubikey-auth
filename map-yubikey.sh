#!/bin/bash

# Check if running as root

if (( $EUID != 0 )); then
    echo "This script must run with root privileges, e.g.:"
    echo "sudo $0 $1"
	echo "Exiting simulation..."
	echo
	echo
    exit
fi


# Inform user on what this script will be doing

echo
echo
echo "This script is going to take the YubiKey that was registered in the previous script"
echo "and then map that YubiKey to the appropriate authentication methods. It will also"
echo "create a file within /etc/udev/rules.d directory to configure auto-locking for the"
echo "user's session. PLEASE MAKE SURE TO RUN THE register-yubikey.sh FIRST!!!!"
echo

# Get user confirmation
while true
do
   read -p "Do you want to proceed? (yes/NO) " PROMPT
   if [ "${PROMPT,,}" == "yes" ] || [ "${PROMPT,,}" == "y" ]
   then
      break
   elif [ "${PROMPT,,}" == "no" ] || [ "${PROMPT,,}" == "n" ] || [ "${PROMPT,,}" == "" ]
   then
      echo "Cancelling, no changes have been made to the system."
      exit
   fi
   echo "Sorry, I didn't understand that. Please type yes or no"
done




map_yubikey()
{
	cd /etc/pam.d
	echo 'auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue' > common-u2f
	for f in gdm-password sudo login; do
		mv $f $f~
		awk '/@include common-auth/ {print "@include common-u2f"}; {print}' $f~ > $f
	done
}

setup_autolock()
{
	cd /etc/udev/rules.d
	echo 'ACTION=="remove", ATTRS{idVendor}=="1050", RUN+="/bin/loginctl lock-sessions"' > 80-yubilock.rules
}

echo
echo
echo "Starting script..."
echo
echo

echo
echo
echo
echo "Mapping YubiKey now..."
map_yubikey
echo
echo
echo
echo "Done, setting up AutoLock feature now..."
setup_autolock
echo
echo
echo
echo "Autolock complete..."
echo "End of script...have a wonderful day!"
echo
echo

