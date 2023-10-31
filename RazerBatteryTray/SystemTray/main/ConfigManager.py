import configparser
import os


class ConfigManager(configparser.ConfigParser):
    def __init__(self, configPath="~/.config/RazerBatteryTrayrc", configDefaultsPath="/etc/RazerBatteryTray.conf") -> None:
        super().__init__(self)
        self.configPath: str = os.path.expanduser(configPath)
        self.configDefaultsPath: str = os.path.expanduser(configDefaultsPath)
        
        # reading default config if main config does not exist, or is empty
        if os.path.isfile(self.configPath) and not os.stat(self.configPath).st_size == 0:
            self.read(self.configPath)
        else:
            print("Config file not found, reading from default configurations.")
            self.read(self.configDefaultsPath)

        
    def writeConfig(self) -> None:
        # writing modified config to self.configPath
        with open(self.configPath, 'w') as conf:
            self.write(conf)
    
                
    def restoreDefaults(self) -> None:
        # copying contents of self.configDefaultsPath to self.configPath
        with open(self.configDefaultsPath, 'r') as defaults, open(self.configPath, 'w') as config:
            config.write(defaults.read())
