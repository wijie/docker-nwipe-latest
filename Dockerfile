FROM debian:stable-slim

ARG SRC_DIR=/root/nwipe_master
ARG URL=https://github.com/martijnvanbrummelen/nwipe.git
WORKDIR ${SRC_DIR}

RUN apt update && \
    apt -y install build-essential \
        pkg-config \
        automake \
        libncurses-dev \
        autotools-dev \
        libparted-dev \
        libconfig-dev \
        libconfig++-dev \
        dmidecode \
        hdparm \
        smartmontools \
        git && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    git clone --depth 1 ${URL} && \
    cd nwipe && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    rm -rf ${SRC_DIR}/nwipe
