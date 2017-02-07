# rickycook/netdata
[![](https://images.microbadger.com/badges/version/thatpanda/netdata.svg)](https://microbadger.com/images/thatpanda/netdata "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/thatpanda/netdata.svg)](http://microbadger.com/images/thatpanda/netdata "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/thatpanda/netdata.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/thatpanda/netdata.svg)][hub]
[hub]: https://hub.docker.com/r/thatpanda/netdata/

[](https://my-netdata.io/) netdata is a system for distributed real-time performance and health monitoring. It provides unparalleled insights, in real-time, of everything happening on the system it runs (including applications such as web and database servers), using modern interactive web dashboards.

* Stunning interactive bootstrap dashboards
* Amazingly fast
* Sophisticated alarming
* Much more...

## Usage

```
docker create \
  --name netdata \
  -e PUID=<UID> -e PGID=<GID> \
  -e TZ=<timezone> \
  -v /proc:/host/proc:ro -v /sys:/host/sys:ro \
  -v </path/to/netdata/config>:/config \
  -p 19999:19999 \
  thatpanda/netdata
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-v /config` netdata configs and logs
* `-v /host/proc` and `-v /host/sys` to allow netdata to read data about the host
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation
* `-e TZ` for timezone information, eg Europe/London
* `-p 19999` web UI port

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it netdata /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

### Setting hostname

* Start, then stop the container so that the config directory is populated
* Edit `</path/to/netdata/config>/netdata.conf`, and add `  hostname = <your.hostname>`
* Restart the container

### Alarms and plugins

Configuration files are copied to the config directory on first run. Manual
config can be done after this.

## Info

* Monitor the logs of the container in realtime `docker logs -f netdata`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' netdata`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' thatpanda/netdata`

## Versions

+ **07.02.17:** Initial Release. 
