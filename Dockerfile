
FROM ubuntu

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
    #autoconf libtool libcurl4-openssl-dev libncurses5-dev pkg-config yasm make libusb-1.0-0-dev libudev-dev libpthread-stubs0-dev make git nano screen && \
    build-essential git autoconf automake make libssl-dev libcurl4-openssl-dev \
    pkg-config libtool libncurses5-dev libudev-dev libusb-1.0-0 libusb-1.0-0-dev \
    libpthread-stubs0-dev yasm nano screen && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/kangaderoo/dualminer-cgminer.git /dualminer-cgminer && \
    cd /dualminer-cgminer && \
    chmod +x autogen.sh && \
    chmod +x configure && \
    ./autogen.sh && \
    ./configure --enable-dualminer --enable-scrypt --disable-opencl && \
    make

WORKDIR /dualminer-cgminer

ENTRYPOINT	["./dualminer-cgminer"]

CMD ["--help"]
