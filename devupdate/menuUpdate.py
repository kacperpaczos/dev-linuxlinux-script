from rich.console import Console
from rich.prompt import Prompt
from rich.progress import Progress
import os

class mintUpdateMenu:
    def __init__(self):
        self.console = Console()
        self.prompt = Prompt()
        self.progress = Progress()

    def update_flatpak(self):
        os.system('sudo flatpak update')
        self.console.print("...ENDED! PRESS ANY KEY TO ESCAPE!")
        response = self.prompt.ask("Remove unused packages [of flatpak]? (y/n): ")
        if response == "y":
            os.system('sudo flatpak uninstall --unused')
            self.console.print("...ENDED! PRESS ANY KEY TO ESCAPE!")

    def update_apt(self):
        os.system('sudo apt update && sudo apt upgrade')
        self.console.print("...ENDED! PRESS ANY KEY TO ESCAPE!")
        response = self.prompt.ask("Remove unused packages [of apt]? (y/n): ")
        if response == "y":
            os.system('sudo apt autoremove')
            self.console.print("...ENDED! PRESS ANY KEY TO ESCAPE!")

    def update_both(self):
        self.update_flatpak()
        self.update_apt()

    def run(self):
        self.console.clear()
        while True:
            self.console.print("Choose option for dev-update: ")
            self.console.print("1) Update flatpak packages")
            self.console.print("2) Update apt packages")
            self.console.print("3) Both... ")
            self.console.print("*) Any key to exit... ")
            choice = self.prompt.ask("Your choice: ")
            if choice == "1":
                self.console.clear()
                self.update_flatpak()
            elif choice == "2":
                self.console.clear()
                self.update_apt()
            elif choice == "3":
                self.console.clear()
                self.update_both()
            elif choice == "*":
                self.console.clear()
                break
