#!/bin/env bash

node=0
django=0

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
    cat $CSINodeDir/server.js > server.js
    cat $CSINodeDir/models/db.js > models/db.js
    cat $CSINodeDir/models/user.model.js > models/user.model.js
    cat $CSINodeDir/views/layouts/mainLayout.html > views/layouts/mainLayout.hbs
    cat $CSINodeDir/views/admin/authenticate.html > views/admin/authenticate.hbs
    cat $CSINodeDir/views/admin/viewUsers.html > views/admin/viewUsers.hbs
    cat $CSINodeDir/views/user/register.html > views/user/register.hbs
    cat $CSINodeDir/routes/user.js > routes/user.js
    cat $CSINodeDir/routes/admin.js > routes/admin.js

    #Template Created
    if [[ $? -eq 0 ]]
    then
        echo "Complete. Node Template was created successfully."
    else
        echo "Error in file creation. Note that CSINodeDir must be set to path/to/directory/.CSI-WebApp-Template/Node/Unix"
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
    echo
    echo "Note: {x y} implies you can use 'csi-cli x' or 'csi-cli y'"
fi
