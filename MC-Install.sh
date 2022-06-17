#!/bin/bash

launcherDownInstall(){
    echo "Where do you want the minecraft launcher to be stored? (provide full path, ex: ~/minecraft_launcher/ TRAILING SLASH!!)"
    read mcPath
    if [[ ! "$mcPath" = */ ]]; then
        echo "Please include a trailing slash!"
        exit 1
    fi

    # Downloads the .desktop file
    wget https://raw.githubusercontent.com/zoofyiscool/MinecraftLauncher-Installer/main/desktopFileTemplate -q

    if [[ -d "$mcPath" ]]; then
        echo "Downloading launcher file!"
        # Downloads launcher.jar to install dir
        wget https://launcher.mojang.com/v1/objects/eabbff5ff8e21250e33670924a0c5e38f47c840b/launcher.jar -O "$mcPath" -q
        # Echos install location to .desktop file.
        echo "Exec=java -jar ${mcPath}launcher.jar" >> desktopFileTemplate
    else # Error handling
        echo "Directory does not exist!"
        exit 1
    fi

    # If .minecraft directory exists, delete it.

    if [[ -d "~/.minecraft" ]]; then
        echo "Removed .minecraft folder."
        rm -rf "~/.minecraft"
    fi

    # Copy .desktop file to the local applications folder, and delete the template that was downloaded.
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
    launcherDownInstall # Call the function
else
    echo "Exiting"
    exit 1
fi
