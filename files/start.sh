#!/bin/bash

cp -f /opt/btsync.tmpl /etc/btsync.conf

# btsync config sync
if [ ! -z $KEY ]
then
  key="$KEY"
else
  key="$( /opt/btsync/rslsync --generate-secret )"
fi

case $MODE in
  "ro")
    rokey="$( /opt/btsync/rslsync --get-ro-secret $KEY )"
    if [ ! -z $rokey ]
    then
      echo "Generated ReadOnly KEY: $rokey"
      echo "---- MODE: ReadOnly ----"
      key=$rokey
    else
      echo "ERR: ReadOnly key generate error"
      exit 1
    fi
    ;;
  "encrypt")
    tmpkey="$( /opt/btsync/rslsync --get-ro-secret $KEY )"
    enckey=$( echo $tmpkey | cut -c-33 | sed -r "s/^(.{1})/F/" )
    if [ ! -z $enckey ]
    then
      echo "Generated Encrypted KEY: $enckey"
      echo "---- MODE: Encrypted ----"
      key=$enckey
    else
      echo "ERR: Encrypted key generate error"
      exit 1
    fi
    ;;
  *)
    echo "KEY: $key"
    echo "---- MODE: Automatic (defined by your key) ----"
    echo "Please copy this key to the other host if nessesary"
    echo -e "\n\n\n"
    ;;
esac


# change btsync conf
sed -i s@--BTSYNCKEY--@$key@g /etc/btsync.conf
sed -i s@--SRVNAME--@$HOSTNAME@g /etc/btsync.conf
#echo -e "\n\nPLEASE COPY THIS BTSYNC KEY to the other hosts: $key \n\n"
echo $key >> /etc/btsync.key

/opt/btsync/rslsync --storage /opt/btsync/config --config /etc/btsync.conf --nodaemon

#/bin/bash
