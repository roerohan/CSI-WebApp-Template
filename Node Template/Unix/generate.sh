#!/bin/env bash

echo "Making directories..."

#Making the directories in the following line
mkdir routes models config partials views views/admin views/user static static/images static/fonts static/css static/js

#Making the files in the following lines
touch server.js models/db.js models/user.model.js

