![alt text](https://github.com/singularthought/uncle-spufus/blob/master/pics/banner.png)

# Uncle Spufus v1.5
A tool that automates MAC address spoofing

## What is Uncle Spufus
# My long story
I remember back in the days when i used macchanger to spoof my MAC address. It would show
that the MAC address was successfully changed. However as soon i connected to wifi network the MAC address
reverted back to the original MAC. I discovered that by accident meaning that those guys who blindly trust
tools would continue to do stuff thinking "Yay! i am using a spoofed MAC Address", but in reality they
were using their original MAC!.

# In short
Uncle spufus uses macchanger however it checks that the MAC is successfully spoofed after connecting to 
a network. It will always fail if a MAC reverts back to the original after connecting to a network. It
tries some well known techniques to spoof your MAC. When it finds the one thats working it saves that
technique for future use.


# Requirements
Inorder to run uncle spufus the following musr be present:
* macchanger
* bash
* ifconfig

## Installing Uncle Spufus

# Method 1: Downloading the zip
1 Download the zip and extract it


# Method 2: Clonig the repo

1. Clone the repository
        `git clone https://github.com/singularthought/uncle-spufus.git`

2. Navigate to uncle-spufus directory:

        `cd uncle-spufus`

3. Make uspufus.sh executable:

        `chmod +× uspufus.sh`

4. From there execute it. 

## Modes of Execution

Note that uspufus has two modes
* Interactive 
* Non-Interactive

# 1. Interactive

1. Execute uspufus without any arguments and follow along
        `./uspufus`

# 2. Non-Interactive

The first argument is the interface that you want to spoof a mac.
The second argument is amount of time(in minutes) to wait before spoofing the MAC
again.


# Example

To spoof wlan0 interface once

        `./uspufus wlan0 0`
        
![alt text](https://github.com/singularthought/uncle-spufus/blob/master/pics/non-int.png)

To spoof wlan0 interface after every 1 minute
        
        `./uspufus wlan0 1`
        
 ![alt text](https://github.com/singularthought/uncle-spufus/blob/master/pics/non-int2.png)

Note the number of minutes can anything you like 5, 10 , 50, 360, 100000, e.t.c


Please report any errors or vulnerabilities to madechangu.takunda@gmail.com
# Peace!!! 


