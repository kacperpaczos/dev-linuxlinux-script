from rich.console import Console
from rich.prompt import Prompt
import os
import shutil

class mintProjectsMenu:
    def __init__(self):
        self.console = Console()
        self.options = {
            "1": self.xapp,
            "2": self.xed,
            "3": self.mintupdate,
            "4": self.cinnamondesktop,
            "*": self.mainmenu
        }

    def run(self):
        while True:
            self.console.print("Choose option: ")
            self.console.print("1) xapp (probably you need this): ")
            self.console.print("2) xed: ")
            self.console.print("3) mintupdate")
            self.console.print("4) cinnamon desktop")
            self.console.print("*) Any key to exit... ")
            choice = Prompt.ask("Enter your choice")
            if choice == "*":
                break
            self.options.get(choice, self.mainmenu)()

    def xapp(self):
        os.mkdir('xapp-dev')
        shutil.chown('xapp-dev', user='root', group='root')
        os.chdir('xapp-dev')

    def xed(self):
        os.mkdir('xed-dev')
        shutil.chown('xed-dev', user='root', group='root')
        os.chdir('xed-dev')

    def mintupdate(self):
        os.mkdir('mintupdate-dev')
        shutil.chown('mintupdate-dev', user='root', group='root')
        os.chdir('mintupdate-dev')
