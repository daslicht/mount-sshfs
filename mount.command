#!/bin/bash

# Config ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

USERNAME=theusername        # for example : root

PASSWORD=thepass            # for example: somethingmorecomplexplease

HOST=thehost                # your host, eg: ansolas.de

REMOTEDIR=/                 # remote dir, /srv/users/daslicht/apps/homepage/public

VOLUMENAME=thevolumename    # this sets the name the mounted folder 

# –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

MOUNTROOT=~/volumes/
MOUNT=$MOUNTROOT/$VOLUMENAME

# Check if Mount  Folder exists, if not create it
# when done call Mount()
CheckIfMountFolderExists() {
  if [ -d "$MOUNT" ]; then
    echo "exists, call mount"
    Mount
  else
    echo "not exists"
    mkdir $MOUNT
  fi
}


# Check if Mount Root Folder exists, if not create and hide it
CheckIfMountROOTFolderExists() {
  if [ -d "$MOUNTROOT" ]; then
    echo "exists, call CheckIfMountFolderExists"
    CheckIfMountFolderExists
  else
    echo "not exists"
    mkdir $MOUNTROOT
    chflags hidden $MOUNTROOT # Hide folder
    CheckIfMountFolderExists
  fi
}
CheckIfMountROOTFolderExists


# Execute the SSHFS Mount command
Mount() {
  echo $PASSWORD | sshfs -o password_stdin -o volname=$VOLUMENAME -o local $USERNAME@$HOST:$REMOTEDIR $MOUNT
}

# guess what :)
echo "done"
