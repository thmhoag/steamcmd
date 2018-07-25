FROM ubuntu:xenial

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt-get install -y ca-certificates steamcmd language-pack-en

RUN ln -s /usr/games/steamcmd /usr/local/bin
RUN adduser --gecos "" --disabled-password steam

WORKDIR /home/steam
USER steam

RUN steamcmd +quit
