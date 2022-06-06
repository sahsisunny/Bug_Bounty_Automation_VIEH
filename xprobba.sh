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

# Creating Folder
url=$1


if [ ! -d "$url" ];then
    printf "\n${BGreen} Creating `$url` named folder.............."
	mkdir $url
    printf "\n${BGreen}[+] Done\n"
fi


cd $url

# Scanning Subdomain
function scanningSubdomains(){

    printf "\n${BYellow}[-] Scanning Subdomains through Sublist3r..............\n"
    python3 ~/tools/subwalker/tools/Sublist3r/sublist3r.py -d $target -t 25 -o $url/Subdomains.txt
    printf "\n${BGreen}[+] Done\n"

    printf "\n${BYellow}[-] Scanning Subdomains through assetfinder..............\n"
    ~/tools/subwalker/tools/assetfinder/assetfinder -subs-only $target >> Subdomains.txt
    printf "\n${BGreen}[+] Done\n"

}

# Filtering and Sorting Subdomains
function FilteringSubdomains(){
    printf "\n${BYellow}[-] Filtering and Sorting Subdomains.............\n"
    cat Subdomains.txt | sort | uniq > SubdomainsSorted.txt
    printf "\n${BGreen}[+] Done\n"

}
# Checking probe for working http and https servers.
function CheckLive(){
    printf "\n${BYellow}[-] Checking probe for working http/https servers...............\n"
    cat SubdomainsSorted.txt | httprobe > aliveSubdomains.txt 
    printf "\n${BGreen}[+] Done\n"
}

# Testing Live subdomains
function testLive(){
    printf "\n${BYellow}[-] Testing Live subdomains..............\n"
    cat aliveSubdomains.txt | $path/subjs/subjs > JsAliveSubdomains.txt
    printf "\n${BGreen}[+] Done\n"
}

# Checking Takeover of Subdomains
function checkTakeover(){
    printf "\n${BYellow}[-] Checking Takeover of Subdomains..............\n"
    ~/tools/subjack/subjack -w aliveSubdomains.txt -c ~/tools/subjack/subjack-2.1/fingerprints.json -t 25 -ssl -o DomainsTakeover.txt
    printf "\n${BGreen}[+] Done\n"
}

# Directory Fuzzing
function DirFuzzing(){
    printf "\n${BYellow}[-] Directory Fuzzing..............\n"
    i=`wc -l < aliveSubdomains.txt`
    while read -r line
    do
        mkdir dir_fuzz
        python3 $path/dirsearch/dirsearch.py -u $line -w $path/wordlist/wordlist.txt -o dir_fuzzing($i).txt
        $i=$i+1
    done < aliveSubdomains.txt
    printf "\n${BGreen}[+] Done\n"

}

# Calling Function
clear
banner
