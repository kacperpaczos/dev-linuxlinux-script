import os
from rich.console import Console
from rich.prompt import Prompt
from rich.progress import Progress
import shutil
import subprocess

# subprojects
from devupdate.menuUpdate import mintUpdateMenu
from devtools.menuTools import toolsMenu

class MainMenu:
    def __init__(self):
        self.console = Console()

        self.updateMenu = mintUpdateMenu()
        self.toolsMenu = toolsMenu()

        self.options = {
            "0": self.devupdatemenu,
            "1": self.devtoolsmenu,
            "2": self.enable_daily_builds,
            "3": self.install_docker_on_LM,
            "4": self.install_prompt_sh_on_LM,
            "5": self.install_oh_my_bash_on_LM,
            "*": self.exit
        }
        self.run()

    def devupdatemenu(self):
        self.updateMenu.run()

    def devtoolsmenu(self):
        self.toolsMenu.run()

    def enable_daily_builds(self):
        print("enable_daily_builds function called")
        tasks = [
            "sudo add-apt-repository ppa:linuxmint-daily-build-team/daily-builds",
            "sudo apt-get update",
            "sudo apt-get upgrade"
        ]
        with self.console.status("[bold green]Working on tasks...") as status:
            while tasks:
                task = tasks.pop(0)
                os.system(task)
                self.console.log(f"{task} complete")

    def install_docker_on_LM(self):
        print("install_docker_on_LM function called")
        tasks = [
            "sudo apt-get update",
            "sudo apt-get install ca-certificates curl gnupg",
            "sudo install -m 0755 -d /etc/apt/keyrings",
            "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
            "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
            'echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "jammy") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null',
            "sudo apt-get update",
            "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
        ]
        with self.console.status("[bold green]Working on tasks...") as status:
            while tasks:
                task = tasks.pop(0)
                os.system(task)
                self.console.log(f"{task} complete")

    def install_prompt_sh_on_LM(self):
        print("install_prompt_sh_on_LM function called")
        tasks = [
            "sudo apt update && sudo apt install wget",
            "mkdir git-prompt",
            "cd git-prompt",
            "wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh",
            "wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash",
            "sudo chmod 664 git-prompt.sh",
            "sudo chmod 664 git-completion.bash",
            "cd .."
        ]
        with self.console.status("[bold green]Working on tasks...") as status:
            while tasks:
                task = tasks.pop(0)
                os.system(task)
                self.console.log(f"{task} complete")

    def install_oh_my_bash_on_LM(self):
        tasks = [
            "sudo apt update && sudo apt install wget",
            "mkdir ohmybash",
            "cd ohmybash",
            'bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"',
            "cd ..",
            "rm -rf ohmybash"
        ]

        with self.console.status("[bold green]Working on tasks...") as status:
            while tasks:
                task = tasks.pop(0)
                os.system(task)
                self.console.log(f"{task} complete")

        print("Who/where is installing it?")
        original_dir = os.getcwd()

        os.chdir('/home')

        for directory in os.listdir('/home'):
            if os.path.isdir(directory):
                print(" > " + directory)

        os.chdir(original_dir)

        username = input("Prompt username: ")

        source = "./git-prompt"
        destination = "/home/" + username + "/.bash_custom"

        print(source)
        print(destination)

        shutil.move(source, destination)

        if os.path.exists(destination):
            print("The files has been successfully moved.")
            subprocess.run(['sudo', 'chown', '-R', username + ':' + username, '/home/' + username + '/.bash_custom'])

            with open('/home/' + username + '/.bashrc', 'a') as file:
                file.write(lines_to_add)
            if os.path.exists("/home/" + username + "/.bashrc"):
                print("The .bashrc file exists.")
                
                if os.path.exists("/home/" + username + "/.bashrc_backup"):
                    shutil.move("/home/" + username + "/.bashrc_backup", "/home/" + username + "/.bashrc")
                    print("Restored .bashrc_backup to .bashrc.")
                shutil.copy("/home/" + username + "/.bashrc", "/home/" + username + "/.bashrc_backup")
                print("Made copy /home/" + username + "/.bashrc to /home/" + username + "/.bashrc_backup.")

                shutil.copy('./bashrc', "/home/" + username + "/.bashrc")

            if os.path.exists(os.path.expanduser("~/.zshrc")):
                print("The .zshrc file exists.")
                print("I DO NOTHING!.")

            input("...ENDED! PRESS ANY KEY TO ESCAPE!")
        else:
            print("An error occurred while moving the files.")
            subprocess.run(['sudo', 'rm', '-Rf', './git-prompt'])
            input("...ENDED! PRESS ANY KEY TO ESCAPE!")


    def exit(self):
        self.console.print("Goodbye!")
        exit()

    def run(self):
        self.console.clear()
        while True:
            self.console.print("[0] Update the system\n[1] Install dev-tools\n[2] Enable daily builds\n[3] Install docker on LM\n[4] Install prompt.sh on LM\n[5] Install oh-my-bash on LM\n[*] Any key to exit")
            choice = Prompt.ask("Choose an option", choices=list(self.options.keys()))
            if choice == "*":
                self.exit()
            self.options[choice]()

if __name__ == "__main__":
    MainMenu()
