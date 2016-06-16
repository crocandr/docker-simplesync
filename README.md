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

You can check this generated key with `docker logs simplesync` command:

Example:
```
PLEASE COPY THIS BTSYNC KEY to the other hosts: AGDEDBKGWD7HOJJF6BUHSVU44Z5UBNZ46
```

2nd, 3rd... container:

You have to define at start the generated (or and old ) key for sync:

```
docker run -tid --name=simplesync --net=host -v /home/myuser/myfiles:/srv/sync -e KEY=AGDEDBKGWD7HOJJF6BUHSVU44Z5UBNZ46 my/simplesync /opt/start.sh
```



Good luck!
