# BtSync based sync container

This container can sync only one folder among other containers.  

## Info

  - https://getsync.com/individuals/

## Build

```
docker build -t my/simplesync .
```

## Run

If you don't have any key, but you have a folder, you can run this container without `KEY`:

```
docker run -tid --name=simplesync --net=host -v /home/myuser/myfiles:/srv/sync my/simplesync /opt/start.sh
```

  - the container syncronize the `/srv/sync` folder in the container among the other simplesync containers 
  - you have to start the simplesync container with `--net=host` parameter
  
At the first start (when you don't define a key), the start script generates a new bittorrent key

You can check this generated key with `docker logs simplesync` command or cat a file:

Example:
```
PLEASE COPY THIS BTSYNC KEY to the other hosts: AGDEDBKGWD7HOJJF6BUHSVU44Z5UBNZ46
```

OR

```
docker exec -ti simplesync cat /etc/btsync.key
```

2nd, 3rd... container:

You have to define at start the generated (or and old ) key for sync:

```
docker run -tid --name=simplesync --net=host -v /home/myuser/myfiles:/srv/sync -e KEY=AGDEDBKGWD7HOJJF6BUHSVU44Z5UBNZ46 my/simplesync /opt/start.sh
```

## Mode

You can change Bittorrent Sync mode with these params:

  - not defined - readwrite mode/automatic
  - `-e MODE=ro` - readonly mode
  - `-e MODE=encrypt` - encrypted mode

Example:

```
docker run -tid --name=simplesync --net=host -v /home/myuser/myfiles:/srv/sync -e KEY=AGDEDBKGWD7HOJJF6BUHSVU44Z5UBNZ46 -e MODE=ro my/simplesync /opt/start.sh
```

You have to define a normal RW key to the container generates a RO or a Encrpyted key.
If you use a RO or an Encrypted key by default, You musn't define the mode switcher parameter. 


Good luck!
