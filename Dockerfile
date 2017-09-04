
FROM ubuntu

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install \
    autoconf libtool libcurl4-openssl-dev libncurses5-dev pkg-config yasm make libusb-1.0-0-dev libudev-dev git nano screen && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/kangaderoo/dualminer-cgminer.git /dualminer-cgminer && \
    cd /dualminer-cgminer && \
    chmod +x autogen.sh configure && \
    ./autogen.sh && \
    ./configure --enable-dualminer --enable-scrypt --disable-opencl  --prefix=/dualminer-cgminer && \
    make

WORKDIR /dualminer-cgminer

ENTRYPOINT	["./dualminer-cgminer"]

CMD ["--help"]
