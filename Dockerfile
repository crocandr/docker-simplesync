FROM ubuntu:xenial

RUN apt-get update && apt-get install -y vim tar less ifupdown net-tools curl unzip

# btsync for config sync
RUN curl -L -o /opt/btsync.tar.gz https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz
RUN mkdir /opt/btsync 
RUN tar xzf /opt/btsync.tar.gz -C /opt/btsync

COPY config/btsync.conf /opt/btsync.tmpl

COPY files/start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

#ENTRYPOINT /opt/start.sh
