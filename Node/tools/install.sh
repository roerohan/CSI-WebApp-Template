#!bin/env bash

cd ~
git clone https://github.com/csivitu/CSI-WebApp-Template .CSI-WebApp-Template
cd .CSI-WebApp-Template/Node/Unix
export CSINodeDir=`pwd`
if [[ -f /usr/bin/csi-cli ]]
then
    sudo rm /usr/bin/csi-cli
fi
cat generate.sh > csi-cli
chmod +x csi-cli
sudo cp csi-cli /usr/bin/
rm csi-cli

echo "Installation Complete."
