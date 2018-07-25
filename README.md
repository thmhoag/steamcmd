[![Build Status](https://img.shields.io/travis/com/thmhoag/steamcmd/master.svg?style=flat-square)](https://travis-ci.com/thmhoag/steamcmd) [![Docker Build Status](https://img.shields.io/docker/build/thmhoag/steamcmd.svg?style=flat-square)](https://hub.docker.com/r/thmhoag/steamcmd/builds/) 
[![Docker Automated build](https://img.shields.io/docker/automated/thmhoag/steamcmd.svg?style=flat-square)](https://hub.docker.com/r/thmhoag/steamcmd/builds/) 
[![Docker Pulls](https://img.shields.io/docker/pulls/thmhoag/steamcmd.svg?style=flat-square)](https://hub.docker.com/r/thmhoag/steamcmd/) 
[![License](https://img.shields.io/dub/l/vibe-d.svg?style=flat-square)](https://github.com/thmhoag/steamcmd/blob/master/LICENSE)


# steamcmd
```
Docker image with steamcmd pre-installed for hosting game servers.
```
## Overview

This image is designed to be a base image for any server run via `steamcmd`. Daily automated builds ensure that the image always contains the latest version of `steamcmd`. When using the image it is recommended to always pull the latest tag to ensure no updates are required when running.

The image inherits from `ubuntu:xenial` for a few reasons:
* Easier for those less familiar with linux to inherit and build from
* Ability to pull `steamcmd` from the apt package manager

### steamcmd Info

* Valve Wiki - https://developer.valvesoftware.com/wiki/SteamCMD
* List of commands - https://github.com/dgibbs64/SteamCMD-Commands-List.git
    * Generously curated and maintained by [dgibbs64](https://github.com/dgibbs64)


### Tags
* latest

## Usage

### Installing the image

Pull the latest:
```bash
docker pull thmhoag/steamcmd
```

### As a base

To use the image as a base, inherit your docker image using the `FROM` annotation in the Dockerfile:
```Dockerfile
FROM thmhoag/steamcmd:latest
```

`steamcmd` has been added to the path so that it can be called easily from any location:
```Dockerfile
RUN steamcmd +app_update 1 +quit
```

### Root/User Caveat

By default, this image runs as the `steam` user and does not have root access inside the container. This is partially due to the way that `steamcmd` expects to be run as a user with the name `steam`, but also for the increased security of not having root inside the container.

If you need root during the build of your image, you can switch users during the build:
```Dockerfile
USER root

RUN my-script-that-needs-root.sh

USER steam
```

If you need root access during the execution of the game server you will need to add the `steam` user to the root user group and make sure it can execute passwordless `sudo` commands. I won't cover that here, as that should not be necessary in the vast majority of cases and is not recommended.

### To run the image

**NOTE:** It is not recommended to run this image by itself, it is indended to be used as a base image when creating game server specific images. (Such as a 7dtd image, ARK image, CSGO image, etc)

To run by itself:
```bash
$ docker run -it thmhoag/steamcmd bash
```

## Contributing

Pull requests are welcome with the caveat that this image is meant to be a base image only and it is not intended to include any additional functionality beyond `steamcmd` itself. 