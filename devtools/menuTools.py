from rich.prompt import Prompt
from rich.console import Console
import os

class toolsMenu:
    def __init__(self):
        self.console = Console()
        self.options = {
            "1": self.install_lib_dev,
            "2": self.install_dev_tools,
            "3": self.git_build_install,
            "4": self.enable_daily_builds,
            "*": self.exit
        }

    def install_lib_dev(self):
        os.system('sudo apt install lib*dev')

    def install_dev_tools(self):
        os.system('sudo apt install git make gcc g++ meson')

    def git_build_install(self):
        os.system('sudo apt install mint-dev-tools --install-recommends')

    def enable_daily_builds(self):
        os.system('sudo flatpak install org.gnome.design.IconLibrary')

    def run(self):
        self.console.clear()
        while True:
            self.console.print("[1] Install lib*dev\n[2] Install dev-tools\n[3] Git, build, install\n[4] Enable daily builds\n[*] Any key to exit")
            choice = Prompt.ask("Choose an option", choices=list(self.options.keys()))
            if choice == "*":
                break
            self.options[choice]()
