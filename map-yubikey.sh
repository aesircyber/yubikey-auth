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
echo "user's session"
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
	echo "This is the map_yubikey function"
}



echo
echo
echo "Starting script..."
echo
echo

map_yubikey

echo
echo
echo "End of script...have a wonderful day!"
echo
echo

