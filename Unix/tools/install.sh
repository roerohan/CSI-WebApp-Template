#!bin/env bash

location=`pwd`
cd ~
if [[ -d .CSI-WebApp-Template ]]
then
    sudo rm -rf .CSI-WebApp-Template
fi
git clone https://github.com/csivitu/CSI-WebApp-Template .CSI-WebApp-Template
cd .CSI-WebApp-Template/Unix
export CSIUnixDir=`pwd`
if [[ -f /usr/bin/csi-cli ]]
then
    sudo rm /usr/bin/csi-cli
fi
cd tools
cat generate.sh > csi-cli
chmod +x csi-cli
sudo cp csi-cli /usr/bin/
rm csi-cli
cd $location
echo "Installation Complete."
