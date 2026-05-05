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
xbps-install -Syu

echo "=============================================="
echo "|     Now let's install all system pkgs      |"
echo "=============================================="
xbps-install -yu $(cat pkg/void.txt)

echo "=============================================="
echo "|     Now let's install Zed                  |"
echo "=============================================="
curl -f https://zed.dev/install.sh | sh

echo "Fixing keyboard"
mkdir -p /etc/X11/xorg.conf.d
tee /etc/X11/xorg.conf.d/00-keyboard.conf << 'EOF'
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "fr"
    Option "XkbVariant" ""
    Option "XkbModel" "pc105"
EndSection
EOF

echo "Creating common folders"
mkdir "/home/ayabusa/Projects"
mkdir "/home/ayabusa/PortableApps"
chown -R ayabusa "/home/ayabusa/Projects" "/home/ayabusa/PortableApps"

echo "Downloading some cool appimages"
curl "https://vencord.dev/download/vesktop/amd64/appimage" > "/home/ayabusa/PortableApps/vesktop.AppImage"
curl "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest/download/DesktopEditors-x86_64.AppImage" > "/home/ayabusa/PortableApps/only-office.AppImage"
curl "https://github.com/Alex313031/thorium/releases/latest/download/Thorium_Browser_138.0.7204.303_AVX2.AppImage" > "/home/ayabusa/PortableApps/thorium.AppImage" 
chown ayabusa "/home/ayabusa/PortableApps/*"
echo "You'll need to install them yourself they are in /home/ayabusa/PortableApps"

cp "config/bg/*" "/home/ayabusa/Pictures"
chown -R ayabusa "/home/ayabusa/Pictures"
