#!/bin/bash

echo "Beginning automated install of Charm Crypto Library."
echo "May take some time to install. Grab a cup of coffee while you wait!"
sleep 3

#Run this script using sudo ./install.sh
#Made for Ubuntu-22.04 LTS on Windows Subsystem for Linux (WSL2)
#Make package folder
mkdir Packages
cd Packages

echo "Directory Packages made successfully. Beginning required libraries and package installations"
sleep 3

#Installing all the required packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install gcc make perl -y
sudo apt-get install m4 flex bison -y
sudo apt-get install python3-setuptools python3-dev libssl-dev libgtest-dev python3-pip -y

echo "Required packages installed successfully"
sleep 3

echo "Using pip3 to install pyparsing 2.4.6"
sleep 3

#Use pip3 to install pyparsing version 2.4.6
pip3 install pyparsing==2.4.6

echo "Pyparsing 2.4.6 installed. Beginning Installation of OpenSSL"
sleep 3

#Begin Installation of OpenSSL
wget "https://www.openssl.org/source/old/1.0.0/openssl-1.0.0s.tar.gz"
sudo tar -xzvf openssl-1.0.0s.tar.gz -C /usr/local/src/
cd /usr/local/src/openssl-1.0.0s/
sudo ./config shared --prefix=/usr/local/openssl --openssldir=/usr/lib/openssl
sudo make
sudo make install

echo "OpenSSL installed successfully. Creating soft links for OpenSSL"
sleep 3

#Create soft links for OpenSSL
sudo mv /usr/bin/openssl /usr/bin/openssl.bak
sudo ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
sudo ln -s /usr/local/openssl/include/openssl /usr/include/openssl

echo "Soft links created successfully. Beginning Dynamic Library Configuration"
sleep 3

#Dynamic Library Configuration
sudo ln -s /usr/local/openssl/lib/libssl.so.1.0.0 /usr/lib/libssl.so
sudo ln -s /usr/local/openssl/lib/libcrypto.so.1.0.0 /usr/lib/libcrypto.so

echo "Dynamic Library Configuration completed. Beginning configuration of ld.so.conf"
sleep 3

#Edit /etc/ld.so.conf
echo "/usr/local/openssl/lib" | sudo tee -a /etc/ld.so.conf
sudo ldconfig

echo "ld.so.conf configuration completed. Beginning Installation of GMP"
sleep 3

#Begin Installation of GMP
cd
cd Packages
wget https://gmplib.org/download/gmp/gmp-6.3.0.tar.xz
sudo tar -xf gmp-6.3.0.tar.xz -C /usr/local/src
cd /usr/local/src/gmp-6.3.0
sudo ./configure
sudo make
sudo make install

echo "GMP installed successfully. Beginning Installation of PBC"
sleep 3

#Begin Installation of PBC
cd
cd Packages
wget https://crypto.stanford.edu/pbc/files/pbc-0.5.14.tar.gz
sudo tar -xzvf pbc-0.5.14.tar.gz -C /usr/local/src
cd /usr/local/src/pbc-0.5.14
sudo ./configure
sudo make
sudo make install

echo "PBC installed successfully. Beginning Installation of Charm Crypto"
sleep 3

#Compile and Install Charm Crypto
#Ensuring git and unzip is installed
sudo apt install git unzip -y
cd
cd Packages
wget https://github.com/JHUISI/charm/archive/refs/heads/dev.zip
sudo mv dev.zip /usr/local/src
cd /usr/local/src
sudo unzip dev.zip
cd charm-dev
sudo ./configure
sudo make
sudo make install

echo "Charm Crypto Installed Successfully!"
sleep 3
echo "Perform verification of library using the following commands in the terminal."
sleep 3
echo "python3"
sleep 3
echo "import charm"
sleep 3
echo "print(charm)"
sleep 3
echo "Test Openssl version now!"

openssl version

echo "If you see no errors, then the installation was successful"
echo "Exiting Bash Script!"
