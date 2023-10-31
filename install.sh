#!/bin/bash

# system install paths
sysInstallPath="/opt/RazerBatteryTray"
sysvenvInstallPath="$sysInstallPath/venv"
syscliPath="/usr/bin/RazerBatteryTray"
sysDesktopPath="/usr/share/applications/RazerBatteryTray.desktop"
sysConfigPath="/etc/RazerBatteryTrayrc"

# getting true user $HOME, even if ran with sudo
usrHome=$(eval echo ~${SUDO_USER})
# user install paths
usrInstallPath="$usrHome/.local/share/RazerBatteryTray"
usrvenvInstallPath="$usrInstallPath/venv"
usrDesktopPath="$usrHome/.local/share/applications/RazerBatteryTray.desktop"
usrConfigPath="$usrHome/.config/RazerBatteryTrayrc"


# system functions
function sysInstallApp() {
    echo "Installing RazerBatteryTray:"
    
    # copying RazerBatteryTray into /opt
    mkdir -p $sysInstallPath
    cp -vr RazerBatteryTray/ $sysInstallPath
    cp -v OpenRazerLogo.svg $sysInstallPath

    # copying venv
    cp -vr venv $sysvenvInstallPath

    # creating defaults config in /etc, user config in ~/.config
    cp -v RazerBatteryTray/SystemTray/data/defaultConfig.conf $sysConfigPath
    cp -v RazerBatteryTray/SystemTray/data/defaultConfig.conf $usrConfigPath
    
    # copying .desktop file in /usr/share/applications
    cp -v installation/system/RazerBatteryTray.desktop $sysDesktopPath

    # copying cli script
    cp -v installation/system/RazerBatteryTray $syscliPath
}


function sysRemoveApp() {
    echo "Uninstalling RazerBatteryTray:"
    
    # removing all files
    rm -vrf $sysInstallPath
    rm -vf $sysConfigPath
    rm -vf $usrConfigPath
    rm -vf $sysDesktopPath
    rm -vf $syscliPath
}


# user functions
function usrInstallApp() {
    echo "Installing RazerBatteryTray:"
    
    # copying RazerBatteryTray into ~/.local/share
    mkdir -p $usrInstallPath
    cp -vr RazerBatteryTray/ $usrInstallPath
    cp -v OpenRazerLogo.svg $usrInstallPath

    # copying venv
    cp -vr venv $usrvenvInstallPath

    # copying config to ~/.config
    cp -v RazerBatteryTray/SystemTray/data/defaultConfig.conf $usrConfigPath

    # replacing '~' in .desktop files with $userHome and writing ~/.local/share/applications
    sed -e "s|~|$usrHome|g" installation/user/RazerBatteryTray.desktop > $usrDesktopPath
    echo "'installation/user/RazerBatteryTray.desktop' -> '$usrHome/.local/share/applications/RazerBatteryTray.desktop'" # pretending to be verbose, sed does not have -v option
}


function usrRemoveApp() {
    echo "Uninstalling RazerBatteryTray:"
    
    # removing all files
    rm -vrf $usrInstallPath
    rm -vf $usrConfigPath
    rm -vf $usrDesktopPath
}


# handling parameters
if [[ "$1" == "install" ]]; then
    if [[ "$2" == "--user" ]]; then
        usrInstallApp
    else
        sysInstallApp
    fi
elif [[ "$1" == "remove" ]]; then
    if [[ "$2" == "--user" ]]; then
        usrRemoveApp
    else
        sysRemoveApp
    fi
else
    echo "Bad usage:
  install      installs RazerBatteryTray, requires root
  remove       uninstalls RazerBatteryTray, requires root
    --user     installs/removes local installation rather than system,
               does not require root"

fi
