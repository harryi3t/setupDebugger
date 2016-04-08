#!/bin/bash

#18-mexec.env

ONE_DIR="$1"
COM_DIR="$ONE_DIR/components"

checkArguments() {
  if [[ -z "$ONE_DIR" ]]; then
    echo "Please pass the absolute path of your one directory"
    exit 0;
  fi
  if [[ ! -d "${ONE_DIR}/components" ]]; then
    echo "$ONE_DIR is not a valid path to one directory. Exiting"
    exit 0;
  fi
}

updateEnvFiles() {
  echo "${GREEN}Updating all the env files in one/components"
  printf "Adding NODEINSPECTOR_PORT & NODEINSPECTOR_DEBUG_PORT\n\n"
  for file in $(ls $COM_DIR -l | grep env | grep -v template | awk '{print NR "-" $9}');
  do
    SERIAL_NUM=$(echo "$file" | awk  -F "-" '{print $1}')
    FILE_NAME=$(echo "$file" | awk  -F "-" '{print $2}')
    NODEINSPECTOR_PORT="$((60000+$SERIAL_NUM))"
    NODEINSPECTOR_DEBUG_PORT="$((60100+$SERIAL_NUM))"

    CONTENT_TO_APPEND="NODEINSPECTOR_PORT=${NODEINSPECTOR_PORT}\n\
NODEINSPECTOR_DEBUG_PORT=${NODEINSPECTOR_DEBUG_PORT}\n"
    printf "$CONTENT_TO_APPEND" >> "$COM_DIR/$FILE_NAME"

  done
}

cleanUpPreviousInstallation() {
  sed -r -i '/NODEINSPECTOR_PORT=[0-9]{5}/d' $COM_DIR"/"*.env
  sed -r -i '/NODEINSPECTOR_DEBUG_PORT=[0-9]{5}/d' $COM_DIR"/"*.env
}

checkArguments
cleanUpPreviousInstallation
updateEnvFiles
