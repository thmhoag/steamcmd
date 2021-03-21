ARG UBUNTU_VERSION=latest
FROM ubuntu:$UBUNTU_VERSION

RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get upgrade -y \
    && echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \
    && apt-get install -y ca-certificates steamcmd locales \
    && locale-gen en_US.UTF-8 \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

RUN ln -s /usr/games/steamcmd /usr/local/bin
RUN adduser --gecos "" --disabled-password steam

WORKDIR /home/steam
USER steam

# uniq is a workaround for steamcmd spamming identical lines
RUN steamcmd +quit | uniq
