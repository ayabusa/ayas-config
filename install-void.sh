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
mkdir -p "/home/ayabusa/Projects"
mkdir -p "/home/ayabusa/PortableApps"
chown -R ayabusa "/home/ayabusa/Projects" "/home/ayabusa/PortableApps"

echo "Downloading some cool appimages"
wget "https://vencord.dev/download/vesktop/amd64/appimage" -o "/home/ayabusa/PortableApps/vesktop.AppImage"
wget "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/latest/download/DesktopEditors-x86_64.AppImage" -o "/home/ayabusa/PortableApps/only-office.AppImage"
wget "https://github.com/Alex313031/thorium/releases/latest/download/Thorium_Browser_138.0.7204.303_AVX2.AppImage" -o "/home/ayabusa/PortableApps/thorium.AppImage" 
wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" -o "/home/ayabusa/Downloads/JetBrainsMono.zip"
chown ayabusa /home/ayabusa/PortableApps/*
echo "You'll need to install them yourself they are in /home/ayabusa/PortableApps"

echo "Installing fonts"
mkdir -p /usr/local/share/fonts
unzip "/home/ayabusa/Downloads/JetBrainsMono.zip" -d /usr/local/share/fonts
rm "/home/ayabusa/Downloads/JetBrainsMono.zip" 
fc-cache -f -v

echo "Installing Bibata cursors"
wget "https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Classic.tar.xz" -o "/home/ayabusa/Downloads/cursor.tar.xz"
mkdir -p "/home/ayabusa/.icons"
tar -xvf "/home/ayabusa/Downloads/cursor.tar.xz" -C "/home/ayabusa/.icons/"
rm "/home/ayabusa/Downloads/cursor.tar.xz"

echo "Downloading GTK theme, you'll need to install it yourself"
wget "https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/archive/refs/heads/main.zip" -o "/home/ayabusa/PortableApps/catpuccin_gtk.zip"

echo "Copying the backgrounds into Pictures"
cp config/bg/* "/home/ayabusa/Pictures"
chown -R ayabusa "/home/ayabusa/Pictures"

echo "Configuring Bash"
cp "config/term/.bashrc" "/home/ayabusa/.bashrc"

echo "Configuring Cinnamon keybinds"
dconf load /org/cinnamon/desktop/keybindings/ < config/wm/keybindings.conf

echo "Configuring Vim"
cp "config/vim/.vimrc" "/home/ayabusa/"
mkdir -p "/home/ayabusa/.vim"
cp -r "config/vim/plugin" "/home/ayabusa/.vim/"

echo "Configuring Zed"
mkdir -p "/home/ayabusa/.config/zed"
cp "config/zed/settings.json" "/home/ayabusa/.config/zed/settings.json"
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
chown -R ayabusa "/home/ayabusa"

echo "All done, you now need to do the following:"
echo "- Build the catpuccin theme"
echo "- Configure all themes and wallpapers in cinnamon"
echo "- Install Appimages"
echo "- Setup SSH keys"
echo "- Have fun :D"
