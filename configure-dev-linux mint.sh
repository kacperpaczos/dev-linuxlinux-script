#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
devlibmenu (){
    clear
	echo "Choose option: "
	echo "1) Install lib*dev: "
	echo "2) Install dev-tools: "
	echo "3) Install dev-tools: "
	read CHOOSE
	case $CHOOSE in
	  1)
	    ;;

	  2)
	    ;;

	  3)
	    ;;

	  *)
	    mainmenu
	    ;;
	esac
}
devtoolsmenu (){
    clear
	echo "Choose option: "
	echo "1) Install org.gnome.Builder"
	echo "2) Install git make gcc g++... "
	read CHOOSE
	case $CHOOSE in
	  1)
	    sudo flatpak install org.gnome.Builder
	    ;;

	  2)
	    sudo apt install git make gcc g++
	    ;;

	  *)
	    mainmenu
	    ;;
	esac
}
mintprojectssmenu(){
    clear
	echo "Choose option: "
	echo "1) Install lib*dev: "
	echo "2) Install dev-tools: "
	echo "3) Clone, build, install... "
	read CHOOSE
	case $CHOOSE in
	  1)
	    devlibmenu
	    ;;

	  2)
	    devtoolsmenu
	    ;;

	  3)
	    mintprojectssmenu
	    ;;

	  *)
	    exit
	    ;;
	esac
}
mainmenu (){
    clear
	echo "Choose option: "
	echo "1) Install lib*dev: "
	echo "2) Install dev-tools: "
	echo "3) Clone, build, install... "
	read CHOOSE
	case $CHOOSE in
	  1)
	    devlibmenu
        mainmenu
	    ;;

	  2)
	    devtoolsmenu
        mainmenu
	    ;;

	  3)
	    mintprojectssmenu
        mainmenu
	    ;;

	  *)
	    exit
	    ;;
	esac
}

mainmenu
