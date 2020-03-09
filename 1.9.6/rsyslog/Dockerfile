FROM debian:buster-slim as openssl

ENV VERSION_OPENSSL=openssl-1.1.1d \
    SHA256_OPENSSL=1e3a91bc1f9dfce01af26026f856e064eab4c8ee0a8f457b5ae30b40b8b711f2 \
    SOURCE_OPENSSL=https://www.openssl.org/source/ \
    BUILD_DEPS="curl build-essential"

WORKDIR /tmp

RUN apt-get update && \
    apt-get install -y $BUILD_DEPS && \
    curl -L $SOURCE_OPENSSL$VERSION_OPENSSL.tar.gz -o openssl.tar.gz && \
    echo "${SHA256_OPENSSL} ./openssl.tar.gz" | sha256sum -c && \
    tar xfz openssl.tar.gz

RUN cd /tmp/$VERSION_OPENSSL && \
    ./config --prefix=/opt/openssl no-shared && \
    make && make install_sw

FROM debian:buster-slim as unbound

ENV UNBOUND_VERSION=unbound-1.9.6 \
    UNBOUND_URL=https://nlnetlabs.nl/downloads/unbound/unbound-1.9.6.tar.gz \
    BUILD_DEPS="curl gcc libc-dev libevent-2.1-6 libevent-dev libexpat1 libexpat1-dev make bsdmainutils ca-certificates ldnsutils"

COPY --from=openssl /opt/openssl /opt/openssl

WORKDIR /tmp

RUN apt-get update && \
    apt-get install -y $BUILD_DEPS && \
    curl -L $UNBOUND_URL -o unbound.tar.gz && \
    tar xzf unbound.tar.gz

RUN cd /tmp/$UNBOUND_VERSION && \
    ./configure \
        --prefix=/opt/unbound \
        --with-pthreads \
        --with-ssl=/opt/openssl \
        --with-libevent \
        --enable-event-api \
    && \
    make && make install

FROM debian:buster-slim

COPY --from=unbound /opt /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
    bsdmainutils \
    ca-certificates \
    ldnsutils \
    libevent-2.1-6\
    libexpat1 \
    rsyslog && \
    groupadd unbound && \
    useradd -d /dev/null -s /bin/false -g unbound unbound

ENV PATH="/opt/unbound/sbin:${PATH}"

COPY docker-entrypoint.sh docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD unbound