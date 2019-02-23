#!/bin/bash

##################################################################################################
#                            UNCLE  SPUFUS                                                       #
#                                                                                                #
#       @name - uncle spufus                                                                     #
#       @version - 1.5                                                                           #
#       @author - Takunda Madechangu                                                             #
#       @description - Uncle spufus is a tool that helps to automate the                         #
#                      work of spoofing MAC address easier. It makes use                         #
#                      of macchanger and other linux system programs. I am                       #
#                      not responsible for whatever happens after you download                   #
#                      this program.                                                             #
#                                                                                                #
#                      FYI Uncle spufus is still in development so do not suprised               #
#                      if you come accross bugs in your exploits/adventures(whatever they are)   #
#                                                                                                #
#       @contact - madechangu.takunda@gmail.com, @madechangu2[twitter],                          #
#                                                                                                #
#                                             WITH LOVE                                          #
##################################################################################################




                    ######################
                    #                    #
                    #       GLOBALS      #
                    #                    #
                    ######################
INTERFACE=wlan0
INTERFACE_ARR=()
OLD_MAC=0
NEW_MAC=1
MAC=2
TECHNIQUES=(tech1 tech2)
RETRY_CHECH_CONN=10
SUCCESS=0
FIRST_ARG=$1
SECOND_ARG=$2

                    #######################
                    #                     #
                    #         TRAPS       #
                    #                     #
                    #######################
trap "onterminate" SIGINT SIGTERM

                    ########################
                    #                      #
                    #     FUNCTIONS        #
                    #                      #
                    ########################

# Banner
function banner()
{
    echo -e  "    ,________________________________________________________________,"
    echo -e  "  ,/   ,--, ,--,                   ,--,                            ,/"
    echo -e  "  |    |  | |  | ,__ ___.   ,____. |  |  ,----,            \`O-O    |"
    echo -e  "   \\   |  | |  | |  \`_   \\ |   __| |  | |  .-. :  [SPUFUS]          \\"
    echo -e  "    |  '  '_'  ' |  | |  |  \\  \\_. |  |  \\  ---,  version: 1.5       |"
    echo -e  "   /    \`------' \`--' '--\`   \`---'  \`-'   \`----'  author: Madechangu/"
    echo -e  "  |                           --Spoof a MAC--                       |"
    echo -e  "   \\________________________________________________________________\\"

}

###################################
#                                 #
#           TECHNIQUES            #
#                                 #
################################### 

# Technique 01
function tech1()
{
    echo "Trying Technique 1..."
    /etc/init.d/network-manager stop 1> /dev/null
    macchanger -b -r $INTERFACE 1> /dev/null
    /etc/init.d/network-manager start 1> /dev/null
}

# Technique 02
function tech2()
{
    echo "Trying Technique 2..."
    ifconfig $INTERFACE down
    macchanger -b -r $INTERFACE 1> /dev/null
    ifconfig $INTERFACE up
}

##################################
#                                #
#     OTHER FUNCTIONS            #
#                                #
##################################

# save technique: saves a working technique
function savetech()
{
    if [ "$CURRENT_TECH" == "`cat $HOME/.uspufus/tech`" ]
    then
        return
    else
        if [ -d $HOME/.uspufus ]
        then
            echo $CURRENT_TECH  > $HOME/.uspufus/tech
        else
            mkdir $HOME/.uspufus
            echo $CURRENT_TECH  > $HOME/.uspufus/tech
            chmod 755 $HOME/.uspufus
            chmod 755 $HOME/.uspufus/tech
        fi
    fi
}

# getinterfaces: get all available interfaces
function getinterfaces()
{
    index=0
    for intfc in `ifconfig | grep flags | awk -F: '{ print $1 }'`
    do
        INTERFACE_ARR[index]=$intfc
        index=`expr $index + 1` 
    done
}

# getmac: get MAC address of the selected interface
function getmac()
{
    MAC=`ifconfig $INTERFACE | grep ether | awk -F" " '{ print $2 }'`
}

# onterminate: get called when someone presses CTRL-C
function onterminate()
{
    /etc/init.d/network-manager restart 1> /dev/null
    echo
    echo "[*] Goodbye!. Come back n pay Uncle Spufus a visit"
    exit
}

# sleepnspoof: spoof mac for every n seconds
function sleepnspoof()
{
    SECONDS=`echo $[$1*60]`

    while [ 0 ]
    do  
        echo "[!] Spoofing mac"
        spoofmac
        echo "[!] Press CTRL-C to stop the spoofer."
        echo 
        sleep $SECONDS
    done
}

# confirmtech: Check if a tecnique was successful
function confirmtech()
{
    # Confirm Technique
    tries=0
    while [ 0 ]
    do
        INET_LINE=`ifconfig $INTERFACE | grep broadcast`
            
        if [ "$INET_LINE" != "" ]
        then
            getmac
            NEW_MAC=$MAC
                
            if [ "$OLD_MAC" != "$NEW_MAC" ]
            then
                echo "[*] MAC Address successfully spoofed!"
                echo "[i] NEW MAC: $NEW_MAC"
                savetech    # Save the working techinique
                SUCCESS=1
                break
            fi
        fi
            
        if [ $tries -eq $RETRY_CHECH_CONN ]
        then
            echo "[!] Checking connection failed"
            exit
        else
            sleep 3
            tries=`expr $tries + 1`
        fi
    done
}

# spoofmac: spoofs MAC address of the selected interface
function spoofmac()
{
    # Get MAC
    getmac
    OLD_MAC=$MAC
    
    # Check for a saved tecnique
    if [ -f $HOME/.uspufus/tech ]
    then
        SIZE=`ls -l $HOME/.uspufus/tech | awk -F" " '{ print $5 }'`
        
        if [ $SIZE -gt 0 ]
        then
            echo "[*] Found a saved technique, using that"
            technique=`cat $HOME/.uspufus/tech`
            $technique
            CURRENT_TECH=$technique
            confirmtech
            
            if [ $SUCCESS -eq 1 ]
            then
                return
            fi
        fi
    fi 
    
    for technique in ${TECHNIQUES[*]}
    do
        $technique
        CURRENT_TECH=$technique
        confirmtech
        
        if [ $SUCCESS -eq 1 ]
        then
            break
        fi
    done
}


# main: TEH MAIN!!!
function main()
{
    if [ $USER != root ]
    then
        echo "[!] I should be run as root"
    else
        getinterfaces
        
        # Check first argument passed first
        if [ "$FIRST_ARG" != "" ]
        then
            INTERFACE_FOUND=0
            for interfc in ${INTERFACE_ARR[*]}
            do
                if [ "$interfc" == "$FIRST_ARG" ]
                then
                    echo "[*] Interface found"
                    INTERFACE_FOUND=1
                    break
                fi
            done
            
            if [ $INTERFACE_FOUND -eq 1 ]
            then
                INTERFACE=$FIRST_ARG
            else
                echo "[-] Interface not found"
                exit
            fi
        else
            # Display Interfaces
            echo
            echo "Interfaces: "
            echo
            index=0
            for interfc in ${INTERFACE_ARR[*]}
            do
                index=`expr $index + 1` 
                echo "$index - $interfc"
            done
        
            # Select Interface
            echo -e "[?] Enter interface[1-$index]:\c "
            read interface_index
            interface_index=`expr $interface_index - 1`
            INTERFACE=${INTERFACE_ARR[$interface_index]}
        fi
        
        # Check second argument second
        if [ "$SECOND_ARG" != "" ]
        then
            re="^[0-9]+$"
            if ! [[ $SECOND_ARG =~ $re ]]
            then
                echo "[-] Argument 2 is not a number" >&2
                exit 1
            else
                if [ $SECOND_ARG -eq 0 ]
                then
                    spoofmac
                else
                    TIME=$SECOND_ARG
                    sleepnspoof $TIME
                fi
            fi
        else            
            clear
            banner
            echo ""
            echo -e "[*] Change MAC:"
            echo
            echo "- 1. once"
            echo "- 2. custom"
            echo -e "[?] Time[ 1 - 2 ]:\c "
            read TIME
            
            if [ $TIME -eq 1 ]
            then
                spoofmac
            elif [ $TIME -eq 2 ]
            then
                echo
                echo "[i] Your MAC address will be spoofed every n minutes. e.g every 5 minutes"
                echo -e "Enter time[minutes]: \c"
                read TIME
                echo
                sleepnspoof $TIME
            else
                echo "[!] Input Error. Exiting"
                exit
            fi
        fi
    fi
}

banner
main

