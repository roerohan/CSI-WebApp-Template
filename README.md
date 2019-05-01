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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/csivitu/CSI-WebApp-Template/master/Unix/tools/install.sh)"
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

```
Create a directory having the name of the Project
Run the command: csi-cli gen -n OR csi-cli gen -d
```

#### The following are the commands that our CLI supports.
```bash
csi-cli {-h --help}: Help
csi-cli {-v --version}: Version
csi-cli {gen generate} {-n --node} <project-name>: Generate Node-js Template
                       {-d --django} <project-name>: Generate Django Template
csi-cli {-D --delete} <project-name>: Delete Project
csi-cli {-r --reset}: Reset All Changes Made to Template
csi-cli {-u --update}: Updates the csi-cli
```
In absence of project-name, csi-cli assumes you are in the project directory.
