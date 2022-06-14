#!/usr/bin/env bash

# Colors
Red='\033[0;31m'          # Red
Blue='\033[0;34m'         # Blue
White='\033[0;37m'        # White
BYellow='\033[1;33m'      # Bold Yellow
BGreen='\033[1;32m'       # Bold Green

Color_Off='\033[0m'       # Text Reset

function banner(){
	printf "\n${BYellow}"
    printf "            B U G  B O U N T Y  A U T O M A T I O N\n"
    printf "           +----------------------------------------+\n"
    printf "${Blue} ██${White}╗  ${Blue}██${White}╗${Blue}██████${White}╗ ${Blue}██████${White}╗  ${Blue}██████${White}╗    ${Red} ██████${White}╗ ${Red}██████${White}╗  ${Red}█████${White}╗  \n"
    printf "${Blue} ${White}╚${Blue}██${White}╗${Blue}██${White}╔╝${Blue}██${White}╔══${Blue}██${White}╗${Blue}██${White}╔══${Blue}██${White}╗${Blue}██${White}╔═══${Blue}██${White}╗   ${Red} ██${White}╔══${Red}██${White}╗${Red}██${White}╔══${Red}██${White}╗${Red}██${White}╔══${Red}██${White}╗ \n"
    printf "${Blue}  ${White}╚${Blue}███${White}╔╝ ${Blue}██████${White}╔╝${Blue}██████${White}╔╝${Blue}██${White}║   ${Blue}██${White}║   ${Red} ██████${White}╔╝${Red}██████${White}╔╝${Red}███████${White}║ \n"
    printf "${Blue}  ██${White}╔${Blue}██${White}╗ ${Blue}██${White}╔═══╝ ${Blue}██${White}╔══${Blue}██${White}╗${Blue}██${White}║   ${Blue}██${White}║   ${Red} ██${White}╔══${Red}██${White}╗${Red}██${White}╔══${Red}██${White}╗${Red}██${White}╔══${Red}██${White}║ \n"
    printf "${Blue} ██${White}╔╝ ${Blue}██${White}╗${Blue}██${White}║     ${Blue}██${White}║  ${Blue}██${White}║╚${Blue}██████${White}╔╝   ${Red} ██████${White}╔╝${Red}██████${White}╔╝${Red}██${White}║  ${Red}██${White}║ \n"
    printf "${White} ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝    ${White} ╚═════╝ ╚═════╝ ╚═╝  ╚═╝ \n"
    printf "${BYellow}"
    printf "+------------------------------------------------------------+\n"
	printf " Version - 0.1.1                              By:- @SahsiSunny\n"
    printf "+------------------------------------------------------------+\n"       
}


# Folder Creating
function CreatingFolder(){
    printf "\n${BYellow}[-] Creating Tools Folder..............\n"
    printf "${Color_Off}"
    if [ ! -d ~/tools/ ]
    then
        mkdir ~/tools/
    fi
    printf "\n${BGreen}[+] Done\n"
}

# Installing Go
function installGo(){
    printf "\n${BYellow}[-] Installing Go-lang..............\n"
    printf "${Color_Off}"
    wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
    sudo tar -xvf go1.13.4.linux-amd64.tar.gz
    sudo mv go /usr/local
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
    echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
    echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile	
    source ~/.bash_profile
    rm go1.13.4.linux-amd64.tar.gz
    printf "\n${BGreen}[+] Done\n"
}
# Installing Github
function installGithub(){
    printf "\n${BYellow}[-] Installing Github..............\n"
    printf "${Color_Off}"
    sudo apt install git -y
    printf "\n${BGreen}[+] Done\n"
}

# Subdomain Finder                                                     
function InstallSubwalker(){
    printf "\n${BYellow}[-] Installing subwalker..............\n"
    printf "${Color_Off}"
    cd ~/tools/
    git clone https://github.com/m8r0wn/subwalker
    cd subwalker
    chmod +x install.sh subwalker.sh
    sudo ./install.sh
    cd -
    printf "\n${BGreen}[+] Done\n"
}

# installing subjs
function installSubjs(){
    printf "\n${BYellow}[-] Installing subjs..............\n"
    printf "${Color_Off}"
    mkdir temp
    cd temp
    wget https://github.com/lc/subjs/releases/download/v1.0.1/subjs_1.0.1_linux_amd64.tar.gz
    tar xvf subjs_1.0.1_linux_amd64.tar.gz
    mv subjs /usr/bin/subjs
    rm subjs_1.0.1_linux_amd64.tar.gz
    cd ../
    sudo rm -rf temp
    printf "\n${BGreen}[+] Done\n"
}

# Installing subjack
function installSubjack(){
    printf "\n${BYellow}[-] Installing subjack..............\n"
    printf "${Color_Off}"
    go install github.com/haccer/subjack@latest
    cd ~/tools/
    git clone  https://github.com/haccer/subjack
    cd -
    sudo apt install subjack -y
    printf "\n${BGreen}[+] Done\n"
}

# Installing httprobe
function installHttprobe(){
    printf "\n${BYellow}[-] Installing httprobe..............\n"
    printf "${Color_Off}"
    go install https://github.com/tomnomnom/httprobe@latest
    sudo apt install httprobe -y
    printf "\n${BGreen}[+] Done\n"
}
# installing Rustscan
function installRustScan(){
    printf "\n${BYellow}[-] Installing Rustscan..............\n"
    printf "${Color_Off}"
    wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
    dpkg -i rustscan_2.0.1_amd64.deb
    rm rustscan_2.0.1_amd64.deb
    printf "\n${BGreen}[+] Done\n"
}
# installing Nmap
function installNmap(){
    printf "\n${BYellow}[-] Installing Nmap..............\n"
    printf "${Color_Off}"
    sudo apt install nmap -y
    printf "\n${BGreen}[+] Done\n"
}

# installing gobuster
function installGobuster(){
    printf "\n${BYellow}[-] Installing Gubuster..............\n"
    printf "${Color_Off}"
    go install github.com/OJ/gobuster/v3@latest
    sudo apt install gobuster -y
    printf "\n${BGreen}[+] Done\n"
}
# Copy Wordlists
function copyWordlist(){
    printf "\n${BYellow}[-] Copying wordlist files..............\n"
    printf "${Color_Off}"
    mv wordlist ~/tools/
    printf "${Color_Off} Copying................................"
    printf "\n${BGreen}[+] Done\n"
}

#Installing whois
function installWhois(){
    printf "\n${BYellow}[-] Installing whois.............\n"
    printf "${Color_Off}"
    sudo apt install whois -y
    printf "\n${BGreen}[+] Done\n"
}


# Run Functions
clear
banner
CreatingFolder
installGithub
installNmap
installRustScan
installHttprobe
installSubjs
installSubjack
installGobuster
copyWordlist
installWhois
InstallSubwalker
