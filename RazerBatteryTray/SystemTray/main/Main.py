from openrazer.client import DeviceManager
from ..main import daemon
from ..main import ConfigManager


def main(args: list) -> None:
    # handling parameters
    try:
        match args[0]:
            case "--restore":
                restoreDefaultConfigs()
            case _:
                print("Bad usage.")
    except IndexError:
        daemon.startDaemon(DeviceManager())


def restoreDefaultConfigs() -> None:
    print("Restoring default configs.")
    ConfigManager.ConfigManager().restoreDefaults()
    