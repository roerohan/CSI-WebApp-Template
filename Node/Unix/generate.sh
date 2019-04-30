#!/bin/env bash

echo "Set up package.json for your project through npm...\n"
npm init
npm install --save express express-handlebars mongoose body-parser express-session
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
echo "Complete."
