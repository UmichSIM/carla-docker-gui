#!/usr/bin/env bash

# add xauth
xauth add $XAUTH_TOKEN

# Unreal Engine build
if ! [[ -f $UE4_ROOT/made ]];then
    cd $UE4_ROOT
    ./Setup.sh
    ./GenerateProjectFiles.sh
    make
    touch made
fi

cd ~/carla
# setup carla
if ! [[ -f ./made ]]; then
  ./Update.sh
  touch made
fi

# launch program
if [[ -f /usr/bin/prime-run ]];then
    prime-run make launch
else
    make launch
fi
