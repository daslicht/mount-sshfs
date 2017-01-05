#!/bin/bash

# Config ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

USERNAME=root

PASSWORD=thepass

HOST=thehost

REMOTEDIR=/ #remote dir 

VOLUMENAME=thehost

# –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

MOUNTROOT=~/volumes/
MOUNT=$MOUNTROOT/$VOLUMENAME


#
CheckIfMountFolderExists() {
  if [ -d "$MOUNT" ]; then
    echo "exists, call mount"
    Mount
  else
    echo "not exists"
    mkdir $MOUNT
  fi
}


# 
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


#
Mount() {
  echo $PASSWORD | sshfs -o password_stdin -o volname=$VOLUMENAME -o local $USERNAME@$HOST:$REMOTEDIR $MOUNT
}


echo "done"
