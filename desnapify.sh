#!/bin/bash
zenity --info --title="Welcome to De-Snapify!" --text="<big>This script will automate the process of removing and disabling snaps, and replacing the snap version of Firefox with a local package version from Mozilla's PPA's.</big>" --width=600
zenity --warning --text="<big>WARNING: Snaps are a important part of the Ubuntu (and all of it's flavors, except Lubuntu) experience.\n\nI am NOT responsible for any damage caused by the script or ANYTHING done by the script in general.\n\nUse this at your own risk.</big>" --title=De-Snapify --width=800
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
sudo apt update -y
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
zenity --info --title=De-Snapify --text="DONE! Snaps have been removed, disabled and the Mozilla PPA version of Firefox has been installed.\n\n Please restart or re-login and enjoy your snap-less Ubuntu experience!" --width=500
else
exit
fi
