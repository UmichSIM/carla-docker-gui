#!/usr/bin/env bash

# add xauth
IFS_OLD=$IFS
IFS=$'\n' read -ra token_array <<< "$XAUTH_TOKENS"
for token in "${token_array[@]}";
do
  xauth add $token
done
IFS=$IFS_OLD

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
