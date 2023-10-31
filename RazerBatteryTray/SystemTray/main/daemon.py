import pystray
from setproctitle import setproctitle
from openrazer.client import DeviceManager
from PIL import Image
from time import sleep
from threading import Thread
from ..main import ConfigManager

# settings process name and getting configs
setproctitle("RazerBatteryTray")
config = ConfigManager.ConfigManager()

def startDaemon(DM: DeviceManager) -> None:
    print(f"Found devices:\n{[(device.name, str(device.battery_level) + '%', device) for device in DM.devices]}\n")
    
    # creating a pystray.Icon with a MenuItem for every battery powered razer device 
    icon = pystray.Icon("RazerBatteryTray", Image.open("RazerBatteryTray/SystemTray/data/OpenRazerLogo.png"), menu=pystray.Menu(
        *[pystray.MenuItem(lambda text, device=device: f"{device.name} {device.battery_level}%", lambda: icon.update_menu()) for device in DM.devices if device.battery_level != None],
        pystray.MenuItem("Exit", lambda: icon.stop())))
    
    
    if config.getboolean("daemon", "autoRefreshBatteryPercentage"):
        Thread(target=continuouslyUpdateMenu, daemon=True, args=(icon, config.getint("daemon", "batteryRefreshIntervalSeconds"),)).start()

    print("Running tray...")
    icon.run()
    

# refreshes battery percentage of devices automatically
def continuouslyUpdateMenu(icon: pystray.Icon, interval: int) -> None:
    while True:
        sleep(interval)
        
        print("Refreshing battery percentage.")
        icon.update_menu()
