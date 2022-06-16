#!/bin/bash

launcherDownInstall(){
    echo "Where do you want the minecraft launcher to be stored? (provide full path, ex: ~/minecraft_launcher/ TRAILING SLASH!!)"
    read mcPath
    if [[ ! "$mcPath" = */ ]]; then
        echo "Please include a trailing slash!"
        exit 1
    fi

    wget https://raw.githubusercontent.com/zoofyiscool/MinecraftLauncher-Installer/main/desktopFileTemplate -q

    if [[ -d "$mcPath" ]]; then
        echo "Downloading launcher file!"
        wget https://launcher.mojang.com/v1/objects/eabbff5ff8e21250e33670924a0c5e38f47c840b/launcher.jar -O /tmp/launcher.jar -q
        mv /tmp/launcher.jar "$mcPath"
        echo "Exec=java -jar ${mcPath}launcher.jar" >> desktopFileTemplate
    else
        echo "Directory does not exist!"
        exit 1
    fi

    if [[ -d "~/.minecraft" ]]; then
        echo "Removed .minecraft folder."
        rm -rf "~/.minecraft" # Remove .minecraft folder
    fi

    cp desktopFileTemplate ~/.local/share/applications/minecraft-old.desktop
    echo "Cleaning.."
    rm desktopFileTemplate
    sleep 1
    echo "Minecraft Launcher has been installed! Just type Minecraft in your app menu!"
    echo "Desktop file was installed in ~/.local/share/applications/minecraft-old.desktop"
    sleep 1
    exit 1
}

echo "Please make sure to uninstall minecraft, and remove the .minecraft folder!!"
echo "(y/n) Continue? (this script will attempt to delete the .minecraft folder if you haven't.)"
read confirm

if [[ $confirm = "y" ]]; then
    launcherDownInstall
else
    echo "Exiting"
    exit 1
fi
