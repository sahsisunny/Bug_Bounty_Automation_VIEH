#!/usr/bin/env bash

# Colors
Red='\033[0;31m'          # Red
Blue='\033[0;34m'         # Blue
White='\033[0;37m'        # White
BYellow='\033[1;33m'      # Bold Yellow
BGreen='\033[1;32m'       # Bold Green


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

printf "####################################################################\n"
printf "########################Installing Tools############################\n"
printf "####################################################################\n"

# Folder Creating
function CreatingFolder(){
    printf "\n${BYellow}[-] Creating Tools Folder..............\n"
    if [ ! -d ~/tools/ ]
    then
        mkdir ~/tools/
    fi
    printf "\n${BGreen}[+] Done\n"
}

# Installing Go
function installGo(){
    printf "\n${BYellow}[-] Installing Go-lang..............\n"
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
    sudo apt install github -y
    printf "\n${BGreen}[+] Done\n"
}

printf "####################################################################\n"
printf "############Installing Subdomain Finder Tools#######################\n"
printf "####################################################################\n"

# Subdomain Finder                                                     
function InstallSubwalker(){
    printf "\n${BYellow}[-] Installing subwalker..............\n"
    cd ~/tools/
    git clone https://github.com/m8r0wn/subwalker
    cd subwalker
    chmod +x install.sh subwalker.sh
    sudo ./install.sh
    printf "\n${BGreen}[+] Done\n"
}

# installing subjs
function installSubjs(){
    printf "\n${BYellow}[-] Installing subjs..............\n"
    go install https://github.com/lc/subjs@latest
    sudo apt install subjs -y
    printf "\n${BGreen}[+] Done\n"
}

# installing dirsearch
function installDirserach(){
    printf "\n${BYellow}[-] Installing dirsearch..............\n"
    cd ~/tools/
    git clone https://github.com/maurosoria/dirsearch.git --depth 1
    cd ~/tools/dirsearch
    pip install -r requirements.txt
    printf "\n${BGreen}[+] Done\n"
}

# Installing subjack
function installSubjack(){
    printf "\n${BYellow}[-] Installing subjack..............\n"
    go install https://github.com/haccer/subjack@latest
    cd ~/tools/
    git clone  https://github.com/haccer/subjack
    cd ../
    sudo apt install subjack -y
    printf "\n${BGreen}[+] Done\n"
}

# Installing httprobe
function installHttprobe(){
    printf "\n${BYellow}[-] Installing httprobe..............\n"
    go install https://github.com/tomnomnom/httprobe@latest
    sudo apt install httprobe -y
    printf "\n${BGreen}[+] Done\n"
}

# Run Functions
clear
banner
