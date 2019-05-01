#!/bin/env bash

node=0
django=0

CSIUnixDir=~/.CSI-WebApp-Template/Unix

#If operation is generate or gen
if [[ $1 =~ "generate" ]] || [[ $1 =~ "gen" ]]
then
    #If option is --node or -n
    if [[ $2 =~ "--node" ]] || [[ $2 =~ "-n" ]]
    then
        node=1

    #If option is --django or -d
    elif [[ $2 =~ "--django" ]] || [[ $2 =~ "-d" ]]
    then
        django=1

    #If the option is any this else
    else
        echo "Invalid request to generate. Choose --node or --django."
    fi

#If the operation is --help or -h
elif [[ $1 =~ "--help" ]] || [[ $1 =~ "-h" ]]
then
    help=1

#If the operation is --version or -v
elif [[ $1 =~ "--version" ]] || [[ $1 =~ "-v" ]]
then
    echo "1.0.0"

#If the operation is --delete or -D
elif [[ $1 =~ "--delete" ]] || [[ $1 =~ "-D" ]]
then
    sudo rm -rf routes models config partials views static server.js package.json package-lock.json node_modules

#If the operation is --reset or -r
elif [[ $1 =~ "--reset" ]] || [[ $1 == "-r" ]]
then
    ls | grep server.js #Check if Node project

    if [[ $? -eq 0 ]]
    then
        sudo rm -rf routes models config partials views static server.js package.json package-lock.json node_modules
        echo "Rebuilding Node Template... "
        node=1
    fi

    ls | grep manage.py #Check if Django project

    if [[ $? -eq 0 ]]
    then
        sudo rm -rf * #TODO
        echo "Rebuilding Django Template... "
        django=1
    fi

#To update the CLI
elif [[ $1 =~ "--update" ]] || [[ $1 =~ "-u" ]]
then
    location=`pwd`
    cd $CSIUnixDir
    cd ../..
    git pull
    cd $location
#For any other option
else
    echo "Invalid arguments."
    echo
    help=1
fi

#To create a Node-js project
if [[ $node -eq 1 ]]
then

    echo "Set up package.json for your project through npm..."
    npm init
    npm install --save express express-handlebars mongoose body-parser express-session bcrypt
    echo "Making directories..."

    #Making the directories in the following line
    mkdir routes models config partials views views/layouts views/admin views/user static static/images static/fonts static/css static/js

    #Making the files in the following lines
    touch server.js models/db.js models/user.model.js views/layouts/mainLayout.hbs views/admin/authenticate.hbs views/admin/viewUsers.hbs views/user/register.hbs routes/user.js routes/admin.js routes/authenticate.js

    echo "Copying files ..."

    #Copying files to the directory
    cat $CSIUnixDir/Node/server.js > server.js
    cat $CSIUnixDir/Node/models/db.js > models/db.js
    cat $CSIUnixDir/Node/models/user.model.js > models/user.model.js
    cat $CSIUnixDir/Node/views/layouts/mainLayout.html > views/layouts/mainLayout.hbs
    cat $CSIUnixDir/Node/views/admin/authenticate.html > views/admin/authenticate.hbs
    cat $CSIUnixDir/Node/views/admin/viewUsers.html > views/admin/viewUsers.hbs
    cat $CSIUnixDir/Node/views/user/register.html > views/user/register.hbs
    cat $CSIUnixDir/Node/routes/user.js > routes/user.js
    cat $CSIUnixDir/Node/routes/admin.js > routes/admin.js
    cat $CSIUnixDir/Node/routes/authenticate.js > routes/authenticate.js

    #Template Created
    if [[ $? -eq 0 ]]
    then
        echo "Complete. Node Template was created successfully."
    else
        echo "Error in file creation. Note that CSIUnixDir must be set to path/to/directory/.CSI-WebApp-Template/Node/Unix"
    fi
fi

#To create a Django project
if [[ $django -eq 1 ]]
then
    echo "Work in Progress."
fi

#Help Menu
if [[ $help -eq 1 ]]
then
    echo "usage: csi-cli <operation> <option>"
    echo "operations:"
    echo
    echo "  csi-cli {-h --help}: Help"
    echo "  csi-cli {gen generate} {-n --node}: Generate Node-js Template"
    echo "                         {-d --django}: Generate Django Template"
    echo "  csi-cli {-D --delete}: Delete Current Project"
    echo "  csi-cli {-r --reset}: Reset All Changes Made to Template"
    echo "  csi-cli {-u --update}: Updates the csi-cli"
    echo
    echo "Note: {x y} implies you can use 'csi-cli x' or 'csi-cli y'"
fi
