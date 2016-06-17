#!/bin/bash

cp -f /opt/btsync.tmpl /etc/btsync.conf

# btsync config sync
if [ ! -z $KEY ]
then
  key="$KEY"
else
  key="$( /opt/btsync/btsync --generate-secret )"
fi

# change btsync conf
sed -i s@--BTSYNCKEY--@$key@g /etc/btsync.conf
sed -i s@--SRVNAME--@$HOSTNAME@g /etc/btsync.conf
echo -e "\n\nPLEASE COPY THIS BTSYNC KEY to the other hosts: $key \n\n"
echo $key >> /etc/btsync.key

/opt/btsync/btsync --storage /opt/btsync/config --config /etc/btsync.conf --nodaemon

#/bin/bash
