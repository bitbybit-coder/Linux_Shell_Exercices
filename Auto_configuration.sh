#!/bin/bash

echo "Starting automated configurations..."
sleep 2

#Check which file format the system uses for package installation (.deb or .rpm)
if dpkg -l &> /dev/null; then
    echo "Your system uses package files in the .deb format"
    
    #Starting system update
    sudo apt update && sudo apt full-upgrade
    
    #Installing some local packages
    sudo apt install \
        build-essential \
        testdisk \
        net-tools \
        wget \
        network-manager -y

    #Installation of external packages
    
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
    

elif rpm -qa > /dev/null 2>&1; then
    echo "Your system uses package files in the .rpm format"

    #Starting system update
    sudo dnf check-update && sudo dnf full-upgrade -y

    #Installing some local packages
    sudo dnf group install "Development Tools" -y
    sudo dnf install testdisk net-tools wget NetworkManager -y

else
    echo "Unsupported system!"
    echo "Terminating automation program..."
    sleep 2
fi
