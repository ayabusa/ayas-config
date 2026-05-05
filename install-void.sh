#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
	then echo "This banger script shall be run as root :)"
 	exit
fi

echo "=============================================="
echo "|   Hey this program will install a lot of   |"
echo "|         software on your computer.         |"
echo "=============================================="

while true; do
	read -p "Do you wish to procede with the installation ? [y/n] " yn
	case $yn in
        [Yy]* ) echo "Great let's install all of that!"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


echo "=============================================="
echo "|       First we update the system !         |"
echo "=============================================="
xbps-install -Su

echo "=============================================="
echo "|     Now let's install all system pkgs      |"
echo "=============================================="
cat pkg/void.txt | xbps-install -u

echo "=============================================="
echo "|     Now let's install Zed                  |"
echo "=============================================="
curl -f https://zed.dev/install.sh | sh


