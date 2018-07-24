FROM ubuntu:xenial

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt-get install -y ca-certificates steamcmd

RUN ln -s /usr/games/steamcmd /usr/local/bin
RUN adduser --gecos "" --disabled-password steam

WORKDIR /home/steam
USER steam

RUN mkdir /home/steam/Steam
VOLUME /home/steam/Steam

RUN steamcmd +quit
