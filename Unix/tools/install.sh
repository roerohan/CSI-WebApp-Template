#!bin/env bash

cd ~
if [[ -d .CSI-WebApp-Template ]]
then
    rm -rf .CSI-WebApp-Template
fi
git clone https://github.com/csivitu/CSI-WebApp-Template .CSI-WebApp-Template
cd .CSI-WebApp-Template/Unix
export CSIUnixDir=`pwd`
if [[ -f ~/.local/bin/csi-cli ]]
then
    rm ~/.local/bin/csi-cli
fi
cd tools
cat generate.sh > csi-cli
chmod +x csi-cli
cp csi-cli ~/.local/bin/
rm csi-cli
echo "Installation Complete."
