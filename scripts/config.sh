#!/usr/bin/env bash

PALWORLD_PATH=${$1:='/palworld'}


DEFAULT_PATH='/$PALWORLD_PATH/DefaultPalWorldSettings.ini'
DESTINATION='/$PALWORLD_PATH/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini'

DEFAULT_CONFIG=$(cat $DEFAULT_PATH)
NEW_CONFIG=$(echo "$DEFAULT_CONFIG" | sed -r 's/;.*//g')
for config in $(printenv | grep 'CONFIG_'); do
  config=${config/CONFIG_}

  cvar=$(echo "$config" | cut -d '=' -f 1)
  cval=$(echo "$config" | cut -d '=' -f 2)

  NEW_CONFIG=$(echo -e "$NEW_CONFIG" | sed -r 's/,/,\n/g' | sed -r "s/$cvar=.*/$cvar=$cval,/g")
done;
NEW_CONFIG=$(echo $NEW_CONFIG | sed -r 's/, /,/g')

echo $NEW_CONFIG > "$DESTINATION"