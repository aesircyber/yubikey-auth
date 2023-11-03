#!/bin/bash

echo
echo
echo
echo "This script will install the required packages,"
echo "then register a YubiKey for the logged in user."
echo "Before starting this script, please ensure you"
echo "have the YubiKey plugged into the system"
echo
echo
echo


# Get user confirmation...

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

# Check to see if required packages are installed first...

echo
echo "Validating packages..."
echo

REQPKG="libpam-u2f"

dpkg -s $REQPKG &> /dev/null

if [ $? -eq 0 ]; then
	echo
	echo "Package $REQPKG is installed, nothing to do..."
	echo
else
	echo
	echo "$REQPKG not installed..."
	echo "Installing $REQPKG now..."
	sudo apt install $REQPKG
fi



register_yubikey()
{
	pamu2fcfg | sudo tee /etc/u2f_mappings
	echo
	echo "YubiKey Registered..."
}


echo
echo
echo "Here we go..."
echo
echo
echo "Touch the YubiKey to register it..."
echo
echo

register_yubikey

echo
echo
echo "That's all she wrote folks...Have a great day!"


