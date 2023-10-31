# RazerBatteryTray
Adds a system tray widget to display battery of Razer devices. Uses Open Razer, most likely only works for Linux.

## Installation
[OpenRazer](https://openrazer.github.io/) daemon must be installed on the system for RazerBatteryTray to work.

System install:
```
git clone https://github.com/Shringe/RazerBatteryTray.git
cd RazerBatteryTray
sudo ./install.sh install 
```
Alternatively, you can install on the user without root privileges, some functionality may be lost:
```
./install.sh install --user
```

## Uninstallation
System uninstallation:
```
sudo ./install.sh remove
```

User uninstallation:
```
./install.sh remove --user
```

## Usage
Use the ```RazerBatteryTray``` command in terminal(system install only), or use the application launcher(start menu) entry.
