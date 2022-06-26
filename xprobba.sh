#!/usr/bin/env bash

# Colors
Red='\033[0;31m'          # Red
Blue='\033[0;34m'         # Blue
White='\033[0;37m'        # White
BYellow='\033[1;33m'      # Bold Yellow
BGreen='\033[1;32m'       # Bold Green

Color_Off='\033[0m'       # Text Reset
# printf "\n${Color_Off}"

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

# Creating Folder
url=$1


if [ ! -d "$url" ];then
    printf "\n${BGreen} Creating `$url` named folder.............."
	mkdir $url
    printf "\n${BGreen}[+] Done\n"
fi

cd $url

# Nmap Scanning MainDomain
function ScanNmap(){

    printf "\n${BYellow}[-] Aggressive Scanning through Nmap..............\n"
    printf "${Color_Off}"
    nmap -A $url > NmapScan_$url.txt 
    printf "\n${BGreen}[+] Done\n"
}

# Scanning Subdomain
function scanningSubdomains(){

    printf "\n${BYellow}[-] Scanning Subdomains through Sublist3r..............\n"
    printf "${Color_Off}"
    python3 ~/tools/subwalker/tools/Sublist3r/sublist3r.py -d $url -o Subdomains.txt
    printf "\n${BGreen}[+] Done\n"

    printf "\n${BYellow}[-] Scanning Subdomains through assetfinder..............\n"
    printf "${Color_Off}"
    ~/tools/subwalker/tools/assetfinder/assetfinder -subs-only $url >> Subdomains.txt
    printf "\n${BGreen}[+] Done\n"

}

# Filtering and Sorting Subdomains
function FilteringSubdomains(){
    printf "\n${BYellow}[-] Filtering and Sorting Subdomains.............\n"
    printf "${Color_Off}"
    cat Subdomains.txt | sort | uniq > SubdomainsSorted.txt
    printf "\n${BGreen}[+] Done\n"

}

# Gathering Whois information
function gatherWhois(){
    printf "\n${BYellow}[-] Filtering and Sorting Subdomains.............\n"
    printf "${Color_Off}"
    whois $url > Whois_$url.com
    printf "\n${BGreen}[+] Done\n"

}

# Checking probe for working http and https servers.
function CheckLive(){
    printf "\n${BYellow}[-] Checking probe for working http/https servers...............\n"
    printf "${Color_Off}"
    cat SubdomainsSorted.txt | httprobe > aliveSubdomains.txt 
    printf "\n${BGreen}[+] Done\n"
}

# Testing Live subdomains
function testLive(){
    printf "\n${BYellow}[-] Testing Live subdomains..............\n"
    printf "${Color_Off}"
    cat aliveSubdomains.txt | subjs > JsAliveSubdomains.txt
    printf "\n${BGreen}[+] Done\n"
}

# Checking Takeover of Subdomains
function checkTakeover(){
    printf "\n${BYellow}[-] Checking Takeover of Subdomains..............\n"
    printf "${Color_Off}"
    subjack -w aliveSubdomains.txt -c ~/tools/subjack/fingerprints.json -t 25 -ssl -o DomainsTakeover.txt -v
    printf "\n${BGreen}[+] Done\n"
}

# Directory Fuzzing
function DirFuzzing(){
    printf "\n${BYellow}[-] Directory Fuzzing..............\n"
    i=`wc -l < aliveSubdomains.txt`
    while read -r line
    do
        if [ ! -d "dir_fuzzing" ];then
            mkdir dir_fuzzing
        fi

        gobuster dir -u $line -w ~/tools/wordlist/wordlist.txt -b 404,301 -t  -o dir_fuzzing/$(echo $line | sed 's/https\?:\/\///').txt
        $i=$i+1
    done < aliveSubdomains.txt

    printf "\n${BGreen}[+] Done\n"

}

# Listing Files - Output
function listingFiles(){

    nmp=`ls NmapScan_$url.txt`
    subdo=`ls Subdomains.txt`
    sortedsub=`ls SubdomainsSorted.txt`
    whos=`ls Whois_$url.com`
    alivesub=`ls aliveSubdomains.txt `
    jsalivsub=`ls JsAliveSubdomains.txt`
    takesub=`ls DomainsTakeover.txt`
    

    printf "${BGreen}\n"
    printf "╔============================================================╗\n"
    printf "║=======================Output Files=========================║\n"
    printf "║============================================================╝\n"
    printf "║====== ${Color_Off} 1. ${nmp} ${BGreen}\n"
    printf "║====== ${Color_Off} 2. ${subdo} ${BGreen}\n"
    printf "║====== ${Color_Off} 3. ${sortedsub} ${BGreen}\n"
    printf "║====== ${Color_Off} 4. ${whos} ${BGreen}\n"
    printf "║====== ${Color_Off} 5. ${alivesub} ${BGreen}\n"
    printf "║====== ${Color_Off} 6. ${jsalivsub} ${BGreen}\n"
    printf "║====== ${Color_Off} 7. ${takesub} ${BGreen}\n"
    printf "║============================================================╗\n"
    printf "║===============Directory Fuzzing Output Files===============║\n"
    printf "║============================================================╝\n"


    cd dir_fuzzing
    ls -l | awk '{ print $9 }' > temp.txt
    tail -n +2 temp.txt > tmp.txt && mv tmp.txt temp.txt
    lnum=`wc -l < temp.txt`
    i=1

    while read -r line || i<=$lnum
    do
        printf "║====== ${Color_Off} $i. ${line}.txt ${BGreen}\n"
        i=$(( i + 1 ))

    done < temp.txt

    rm temp.txt

    printf "╚============================================================+\n"

}

# For Output Questions
function needOutput(){
    read -p "Do you want to open output in GUI Mode?(Yes/No): " ans 
    if [ $ans == "yes" ] || [ $ans == "Yes" ] || [ $ans == "y" ] || [ $ans == "Y" ] || [ $ans == "YES" ]
    then
        xdg-open ./
    elif [ $ans == "no" ] || [ $ans == "No" ] || [ $ans == "n" ] || [ $ans == "N" ] || [ $ans == "NO" ]
    then
        clear
        banner
        listingFiles
    else
        echo "Please enter valid answer!!"
    fi
}

# Calling Function
clear
banner
ScanNmap
gatherWhois
scanningSubdomains
FilteringSubdomains
CheckLive
testLive
checkTakeover
DirFuzzing
needOutput
