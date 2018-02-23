FROM ubuntu:xenial

LABEL maintainer="pieter@pi-q.nl"

RUN apt-get update \
      && apt-get install -y --no-install-recommends ca-certificates=20170717~16.04.1 wget=1.17.1-1ubuntu1 \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wagerr/wagerr/releases/download/v1.4.34.1/wagerr-1.4.34.1-x86_64-linux-gnu.tar.gz \
      && mkdir wagerr \
      && tar xzf wagerr*.tar.gz -C wagerr --strip-components 1 \
      && ln -s /wagerr/bin/* /usr/local/bin

VOLUME /wgrdata

EXPOSE 55002

CMD ["wagerrd", "-datadir=/wgrdata", "-printtoconsole"]

