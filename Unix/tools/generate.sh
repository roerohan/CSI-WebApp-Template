#!/bin/env bash

node=0
django=0

CSIUnixDir=~/.CSI-WebApp-Template/Unix

#If operation is generate or gen
if [[ $1 =~ "generate" ]] || [[ $1 =~ "gen" ]]
then
    if [[ $# -gt 3 ]]
    then
        echo "Too many arguments!"
        exit 1
    fi
    project_name=$3
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
    read -p "Are you sure? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        if [[ ! -z "$2" ]]
        then
            ls -a | grep $2 && rm -rf $2 || echo "'$2' not found."
        else
            rm -rf routes models config partials views static server.js package.json package-lock.json node_modules
        fi
    else
        echo "No files were deleted."
        exit 1
    fi

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
    cd $CSIUnixDir
    git pull
#For any other option
else
    echo "Invalid arguments."
    echo
    help=1
fi

#To create a Node-js project
if [[ $node -eq 1 ]]
then

    # echo "Set up package.json for your project through npm..."
    # npm init
    # npm install --save express express-handlebars mongoose body-parser express-session bcrypt
    echo "Making directories..."


    if [[ -z "$project_name" ]]
    then
        echo "Missing project name."
        echo "Creating project named NodeProject"
        project_name="NodeProject"
    fi

    mkdir $project_name
    cd $project_name

    #Making the directories in the following line
    mkdir config partials static static/images static/fonts static/css static/js

    #Making the files in the following lines
    touch server.js

    echo "Copying files ..."

    #Copying files to the directory
    cat $CSIUnixDir/Node/server.js > server.js
    cat $CSIUnixDir/Node/package.json > package.json
    cat $CSIUnixDir/Node/package-lock.json > package-lock.json

    cp -r $CSIUnixDir/Node/models models
    cp -r $CSIUnixDir/Node/views views
    cp -r $CSIUnixDir/Node/node_modules node_modules
    cp -r $CSIUnixDir/Node/routes routes

    #Template Created
    if [[ $? -eq 0 ]]
    then
        echo "Complete. Node Template was created successfully."
    else
        echo "Error in file creation. Note that CSIUnixDir must be set to path/to/directory/.CSI-WebApp-Template/Unix"
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
