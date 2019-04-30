# CSI-WebApp-Template

The CSI-WebApp-Template is a CLI tool which helps you generate a Node-js or Django template for a Website with features such as:-

    Connect to Database
    Basic User Model
    Add User (with hashed password)
    Admin Panel - Add, Update, Delete User
    Authentication with Sessions
    Admin Login/Logout
    User Login/Logout

## Installation

The CSI-WebApp-Template CLI can be installed for both Windows and Unix-based Operating Systems.

### For Windows

```bash
#TODO
```

### For Unix-Based OS

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/csivitu/CSI-WebApp-Template/master/Node/tools/install.sh)" #TODO
```
#### OR
```bash
git clone https://github.com/csivitu/CSI-WebApp-Template.git
cd CSI-WebApp-Template
./install.sh
#TODO
```

## Requirements

### For Node-js Template
```
Node-js (with npm)
MongoDB
```

### For Django Template
```
Python 3.6+ (with pip)
Django: Do - pip install django
```

## Usage

The following are the commands that our CLI supports

```bash
csi-cli {-h --help}: Help
csi-cli {gen generate} {-n --node}: Generate Node-js Template
                       {-d --django}: Generate Django Template
csi-cli {-D --delete}: Delete Current Project
csi-cli {-r --reset}: Reset All Changes Made to Template
csi-cli {-u --update}: Updates the csi-cli
```
