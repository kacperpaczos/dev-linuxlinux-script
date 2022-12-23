#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

BASEDIR=$(pwd)
devlibmenu (){
    clear
    cd $BASEDIR
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
    cd $BASEDIR
	echo "Choose option for dev-tools: "
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
	echo "Choose option for xapp: "
	echo "1) clone: "
    echo "2) syncfork (you need 1 first! ): "
    echo "3) build "
    echo "4) install "
    echo "5) clear ALL "

    cd ..

	read CHOOSE
	case $CHOOSE in
	  1)
        
        cd xapp-dev
        git clone https://github.com/kacperpaczos/xapp.git
        sudo chmod 777 -R ./xapp
        cd xapp
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xappmenu
	    ;;
      2)
        cd xapp
        git fetch upstream
        git checkout master
        git merge upstream/master
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xappmenu
	    ;;
      3)
        sudo apt install libxml2-dev cmake meson libglib2.0-dev libgtk-3-dev libgtksourceview-4-dev libpeas-dev libgnomekbd-dev valac python-gi-dev gir1.2-dbusmenu-gtk3-0.4 libxkbfile-dev
        cd xapp
        meson --prefix=/usr build
        read -p "...ENDED! CLICK TO GO NEXT!"
        ninja -v -C build
        read -p "...ENDED! CLICK TO GO NEXT!"
        
	    xappmenu
	    ;;
      4)
        cd xapp
        sudo ninja install -v -C build
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xappmenu
	    ;;
    
      5)
        
        cd ..
        sudo rm -R ./xapp-dev
        read -p "...ENDED! CLICK TO GO NEXT!"
	    mintprojectssmenu
	    ;;
	  *)
	    mintprojectssmenu
	    ;;
	esac

}
xedmenu(){
    clear
	echo "Choose option for xed: "
	echo "1) clone: "
    echo "2) syncfork (you need 1 first! ): "
    echo "3) build "
    echo "4) install "
    echo "5) clear ALL "

    cd ..

	read CHOOSE
	case $CHOOSE in
	  1)
        
        cd xed-dev
        git clone https://github.com/kacperpaczos/xed.git
        sudo chmod 777 -R ./xed
        cd xed
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xedmenu
	    ;;
      2)
        cd xed
        git fetch upstream
        git checkout master
        git merge upstream/master
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xedmenu
	    ;;
      3)
        sudo apt install libxml2-dev cmake meson libglib2.0-dev libgtk-3-dev libgtksourceview-4-dev libpeas-dev libgspell-1-dev intltool itstool
        cd xed
        
        meson --prefix=/usr build
        read -p "...ENDED! CLICK TO GO NEXT!"
        ninja -v -C build
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xedmenu
	    ;;
      4)
        cd xed
        sudo ninja install -v -C build
        read -p "...ENDED! CLICK TO GO NEXT!"
	    xedmenu
	    ;;
      5)
        cd ..
        sudo rm -R ./xed-dev
        read -p "...ENDED! CLICK TO GO NEXT!"
	    mintprojectssmenu
	    ;;

	  *)
	    mintprojectssmenu
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
        mkdir xapp-dev
        sudo chmod 777 -R ./xapp-dev
        cd xapp-dev
	    xappmenu
	    ;;

      2)
        mkdir xed-dev    
        sudo chmod 777 -R ./xed-dev
        cd xed-dev
        
	    xedmenu
	    ;;


	  *)
	    mainmenu
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
