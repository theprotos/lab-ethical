#!/usr/bin/bash

#Set Script Name variable
SCRIPT=`basename ${BASH_SOURCE[0]}`
#Set fonts for Help.
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

while getopts "i:m:h" flag
do
    case "${flag}" in
        i) interface=${OPTARG:-"eth0"}
           CHANGE;;
        m) mac=${OPTARG:-"00:00:00:00:00:00"};;
           CHANGE;;
        h) HELP;;
        \?) echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed."
           HELP;;
    esac
done

#while :; do
#    case $1 in
#        -a|--flag1) flag1="SET"
#        ;;
#        -b|--flag2) flag2="SET"
#        ;;
#        -c|--optflag1) optflag1="SET"
#        ;;
#        -d|--optflag2) optflag2="SET"
#        ;;
#        -e|--optflag3) optflag3="SET"
#        ;;
#        *) break
#    esac
#    shift
#done

function CHANGE {
echo "Temporary change MAC: $interface -> $mac"
ifconfig $interface down
ifconfig $interface hw ether $mac #00:11:22:33:44:55
ifconfig $interface up
exit $?
}

# Promics mode
#iwconfig wlan0 down
#iwconfig wlan0 mode monitor
#iwconfig wlan0 up

function HELP {
echo -e "\nHelp documentation for ${BOLD}${SCRIPT}.${NORM}\n"
exit 1
}