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
	    sudo apt install git make gcc g++ meson
	    ;;

	  *)
	    mainmenu
	    ;;
	esac
}

xappmenu(){
clear
	echo "Choose option: "
	echo "1) clone: "
    echo "2) syncfork (you need 1 first! ): "
    echo "3) build "
    echo "4) install "
	read CHOOSE
	case $CHOOSE in
	  1)
        git clone https://github.com/kacperpaczos/xapp.git
        sudo chmod 777 -R ./xapp
        read
	    xappmenu
	    ;;
      2)
        cd xapp
        ls -l
        git fetch upstream
        git checkout master
        git merge upstream/master
        read
	    xappmenu
	    ;;
      3)
        sudo apt install libxml2-dev cmake meson libglib2.0-dev libgtk-3-dev libgtksourceview-4-dev libpeas-dev libgnomekbd-dev valac python-gi-dev gir1.2-dbusmenu-gtk3-0.4
        cd xapp
        meson --prefix=/usr build
        read
        ninja -v -C build
        read
        sudo ninja install -v -C build
	    xappmenu
	    ;;
      4)
	    xappmenu
	    ;;


	  *)
	    exit
	    ;;
	esac

}
xedmenu(){
    clear
	echo "Choose option: "
	echo "1) clone: "
    echo "2) syncfork (you need 1 first! ): "
    echo "3) build "
    echo "4) install "
	read CHOOSE
	case $CHOOSE in
	  1)
        git clone https://github.com/kacperpaczos/xed.git
        sudo chmod 777 -R ./xed
        read
	    xedmenu
	    ;;
      2)
        cd xed
        ls -l
        git fetch upstream
        git checkout master
        git merge upstream/master
        read
	    xedmenu
	    ;;
      3)
        sudo apt install libxml2-dev cmake meson libglib2.0-dev libgtk-3-dev libgtksourceview-4-dev libpeas-dev
        cd xed
        meson --prefix=/usr build
        read
        ninja -v -C build
        read
        sudo ninja install -v -C build
	    xedmenu
	    ;;
      4)
	    xedmenu
	    ;;


	  *)
	    exit
	    ;;
	esac
}
mintprojectssmenu(){
    clear
	echo "Choose option: "
    echo "1) xapp: "
	echo "2) xed: "
	read CHOOSE
	case $CHOOSE in
	  1)
	    xappmenu
	    ;;

      2)
	    xedmenu
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
	echo "3) Git, build, install... "
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
