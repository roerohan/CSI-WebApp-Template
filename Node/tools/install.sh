#!bin/env bash

cd ~
git clone https://github.com/csivitu/CSI-WebApp-Template .CSI-WebApp-Template
cd .CSI-WebApp-Template/Node/Unix
export CSINodeDir=`pwd`
cat generate.sh > csi-cli
chmod +x csi-cli
sudo cp csi-cli /bin/
rm csi-cli

echo "Installation Complete."
