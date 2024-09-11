> [!WARNING]
> I literally just wrote this script, so it's very, **VERY** new. There will be problems!!!
# De-Snapify
Simple zenity + Bash script for removing and disabling snaps and installing Firefox from Mozilla's PPA in Ubuntu.

Dead simple, made to work and not to look pretty.  
Might add an option to install Flatpak + GNOME Software in the future.  
This was primarily made just for myself but feel free to use it.

> [!IMPORTANT]  
> This was only tested on Ubuntu 24.04 LTS stock so far.

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

or you can just simply download the script directly either with **wget** or [by opening the raw contents and saving it via your web browser.](https://raw.githubusercontent.com/canofjuice/desnapify/main/desnapify.sh)

```
sudo apt update && sudo apt install wget
wget https://raw.githubusercontent.com/canofjuice/desnapify/main/desnapify.sh
sh desnapify.sh
```
