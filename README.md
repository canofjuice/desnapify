> [!WARNING]
> I literally just wrote this script, so it's very, **VERY** new. There will be problems!!!
# De-Snapify
Simple zenity + bash script for removing and disabling snaps and installing extra software afterwards.

Dead simple, made to work and not to look pretty.  
Allows you to install Firefox, Chromium, Flatpak and AppImage after the removal.  
This was primarily made just for myself but feel free to use it.

> [!IMPORTANT]  
> This was only tested on Ubuntu and Kubuntu 24.04 LTS stock so far.

> [!CAUTION]
> I am NOT responsible for any damage caused by this script. Snaps are a important part of Ubuntu's experience.
> Use at your own risk!

![Screenshot](https://github.com/canofjuice/desnapify/blob/main/desnapify-screenshot.png?raw=true)

## How to?

You can either run the script directly from a terminal by first making sure **curl** is installed:
```
sudo apt update && sudo apt install curl
```

then executing the following command:
```
curl -L https://raw.githubusercontent.com/canofjuice/desnapify/main/desnapify.sh | bash
```

get the KDialog version if you're on Kubuntu:
```
curl -L https://raw.githubusercontent.com/canofjuice/desnapify/main/desnapify-qt.sh | bash
```

or you can just simply download the script directly either with **wget** or [by opening the raw contents and saving it via your web browser.](https://raw.githubusercontent.com/canofjuice/desnapify/main/desnapify.sh)

```
sudo apt update && sudo apt install wget
wget https://raw.githubusercontent.com/canofjuice/desnapify/main/desnapify.sh
bash desnapify.sh
```
Replace desnapify.sh with **desnapify-qt.sh** if you're on Kubuntu.
