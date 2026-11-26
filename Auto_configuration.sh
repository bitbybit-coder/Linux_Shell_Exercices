#!/bin/bash

echo "              Starting automated configurations...              "
sleep 2

source /etc/os-release

#Check which file format the system uses for package installation (.deb or .rpm)
case "$ID" in
    ubuntu|debian|linuxmint|pop) 
     
    echo "================================================================"
    echo "       YOUR SYSTEM  USES PACKAGE FILES IN THE .DEB FORMAT       "
    echo "================================================================"

    echo "----------------------------------------------------------------"
    echo "            Update and installing some local packages           "
    echo "----------------------------------------------------------------"
    #Starting system update
    sudo apt update && sudo apt full-upgrade -y
    #If any packages are being held back
    sudo apt list --upgradable 2>/dev/null | tail -n +2 | cut -d"/" -f1 | xargs -r sudo apt upgrade -y
    
    #Installing some local packages
    sudo apt install \
        build-essential \
        testdisk \
        net-tools \
        wget \
        network-manager \
        qbittorrent \
        gparted \
        dosfstools \
        mtools \
        htop \
        hunspell-pt-br -y

    echo "-----------------------------------------------------------------"
    echo "                Installation of external packages                "      
    echo "-----------------------------------------------------------------"
    
    #VS CODE
    #Automatically accepts the addition of official Microsoft repositories
    echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
    wget -O $HOME/Downloads/code.deb https://vscode.download.prss.microsoft.com/dbazure/download/stable/8a14f0cc1b08d531eb83255ea3764ae22aa932b5/code_1.147.0-1794903003_amd64.deb &&
    sudo apt install $HOME/Downloads/code.deb -y &&
    sudo dpkg --configure -a &&
    sudo rm $HOME/Downloads/code.deb

    #GOOGLE CHROME
    wget -O $HOME/Downloads/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
	sudo apt install $HOME/Downloads/chrome.deb -y &&
	sudo dpkg --configure -a &&
	sudo rm $HOME/Downloads/chrome.deb

    #VIRTUALBOX
    wget -O $HOME/Downloads/vbox.deb https://download.virtualbox.org/virtualbox/7.2.22/virtualbox-7.2_7.2.22-175245~Ubuntu~resolute_amd64.deb &&
	sudo apt install $HOME/Downloads/vbox.deb -y &&
	sudo dpkg --configure -a &&
	sudo rm $HOME/Downloads/vbox.deb
    
    
    #Final adjustments and removal of residual files
    sudo apt install -f -y
    sudo apt autoremove -y
    sudo apt clean
    sudo apt autoclean

    ;;

fedora)

    echo "================================================================="
    echo "       YOUR SYSTEM  USES PACKAGE FILES IN THE .RPM FORMAT        "
    echo "================================================================="

    echo "-----------------------------------------------------------------"
    echo "            Update and installing some local packages            "
    echo "-----------------------------------------------------------------"
    #Starting system update
    sudo dnf upgrade --refresh -y
    
    #Installing some local packages
    sudo dnf install \
        @development-tools \
        testdisk \
        net-tools \
        wget \
        NetworkManager \
        qbittorrent \
        gparted \
        dosfstools \
        mtools \
        htop \
        hunspell-pt -y

    # VIRTUALBOX
    sudo dnf install kernel-devel kernel-headers gcc make perl elfutils-lebelf-devel -y
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf install VirtualBox kernel-devel-$(uname -r) -y

    echo "-----------------------------------------------------------------"
    echo "                Installation of external packages                "      
    echo "-----------------------------------------------------------------"
    
    # VS CODE
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null &&
    sudo dnf install code -y

    # GOOGLE CHROME
    wget -O $HOME/Downloads/chrome.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm &&
    sudo dnf install $HOME/Downloads/chrome.rpm -y &&
    sudo rm $HOME/Downloads/chrome.rpm

    #Final adjustments and removal of residual files
    sudo dnf check
    sudo dnf autoremove -y
    sudo dnf clean all

    ;;

*)
    echo "Unsupported system!"
    echo "Terminating automation program..."
    sleep 2

    ;;
esac
