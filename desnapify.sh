#!/bin/bash

# Functions

install_firefox () {
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt update && sudo apt install firefox -y
}

install_chromium () {
sudo add-apt-repository ppa:savoury1/chromium
sudo apt update
sudo apt install chromium-browser chromium-codecs-ffmpeg-extra -y
}

install_flatpak () {
sudo apt install flatpak gnome-software gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

install_appimage_support () {
sudo apt install libfuse2t64 wget libqt5core5t64 libqt5dbus5t64 libqt5gui5t64 libqt5widgets5t64 -y
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo dpkg -i appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
rm appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
}

# Main script

zenity --info --title="Welcome to De-Snapify!" --text="<big>This script will automate the process of removing and disabling snaps. You will also be asked if you want to install a web browser, Flatpak and AppImage support after the process is done.</big>" --width=800
zenity --warning --text="<big>WARNING: Snaps are a important part of the Ubuntu (and all of it's flavors, except Lubuntu) experience.\n\nI am NOT responsible for any damage caused by the script.\n\nUse this at your own risk.</big>" --title=De-Snapify --width=600
zenity --question --text="<big>Proceed with removing snaps?</big>" --title=De-Snapify --width=400
if [ $? = 0 ] ; then
sudo snap remove firefox
sudo systemctl disable --now snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd
rm -rf ~/snap/
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
sudo apt update 
sudo apt install gdebi ;
else
zenity --warning --text="<big>Script aborted. Press OK to exit.</big>" --title=De-Snapify
exit ;
fi
zenity --question --text="<big>Would you like to install Firefox from Mozilla's repositories?</big>" --title=De-Snapify --width=500
if [ $? = 0 ] ; then
install_firefox ;
fi
zenity --question --text="<big>Would you like to install Chromium (Open-source version of Chrome)?</big>" --title=De-Snapify --width=600
if [ $? = 0 ] ; then
install_chromium ;
fi
zenity --question --text="<big>Would you like to install Flatpak support (includes GNOME Software)?</big>" --title=De-Snapify --width=600
if [ $? = 0 ] ; then
install_flatpak ;
fi
zenity --question --text="<big>Would you like to install AppImage support?</big>" --title=De-Snapify --width=500
if [ $? = 0 ] ; then
install_appimage_support ;
fi
zenity --question --text="<big>In case you did not choose to install a web browser, would you like to have instructions on how to install either web browsers be saved in your home folder?</big>" --width=600 --title=De-Snapify
if [ $? = 0 ] ; then
echo "Making sure wget is installed"
sudo apt update
sudo apt install wget
wget https://raw.githubusercontent.com/canofjuice/desnapify/main/browser_install_instructions.txt ~ ;
fi
zenity --info --title=De-Snapify --text="<big>DONE! Snaps have been removed and disabled from your system.\n\nPlease restart or re-login and enjoy your snap-less Ubuntu experience.</big>" --width=700
exit
