![alt text](https://github.com/singularthought/uncle-spufus/blob/master/pics/banner.png)

# Uncle Spufus v1.5
A tool that automates MAC address spoofing

## What is Uncle Spufus
Uncle Spufus is a tool that automates MAC 
address spoofing. Inorder to accomplish that
it tries various techniques and checks if the 
MAC is successfully spoofed. This update saves
a working technique so that you don't loop through
the whole list of techniques again.


Inorder to run uspufus the following musr be present:
* macchanger
* bash (which comes already installed)

## Installing Uncle Spufus
1 Download the zip and extract it

OR

1. Clone the repository
        `git clone https://github.com/singularthought/uncle-spufus.git`

THEN

2. Navigate to uncle-spufus directory:

        `cd uncle-spufus`

3. Make uspufus.sh executable:

        `chmod +× uspufus.sh`

4. From there execute it. 

Note that uspufus has two modes
* Interactive 
* Non-Interactive

## Interactive

1. Execute uspufus without any arguments and follow along
        `./uspufus`

## Non-Interactive

The first argument is the interface that you want to spoof a mac.
The second argument is amount of time(in minutes) to wait before spoofing the MAC
again.


# Example

To spoof wlan0 interface once

        `./uspufus wlan0 0`
        
        ![alt text](https://github.com/singularthought/uncle-spufus/blob/master/pics/non-int.png)

To spoof wlan0 interface after every 1 minute
        
        `./uspufus wlan0 1`
        
        ![alt text](https://raw.githubusercontent.com/singularthought/uncle-spufus/master/pics/non-int2.png)

Note the number of minutes can anything you like 5, 10 , 50, 360, 100000, e.t.c

Have fun 


# DONATE BITCOIN TO TAKUNDA MADECHANGU

Please send 0.00048916 BTC(2 USD) to the Bitcoin Address 14AEtGfHSVYLjfY5yQTq9vKx1mBbCp1qkS

        ![alt text](https://raw.githubusercontent.com/singularthought/uncle-spufus/master/pics/non-int.png)


