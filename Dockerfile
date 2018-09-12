FROM debian:stable-slim

LABEL maintainer="lukogex"
ARG version
ARG uid

RUN apt-get update \
      && apt-get install -y --no-install-recommends ca-certificates wget \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wagerr/wagerr/releases/download/v${version}/wagerr-${version}-x86_64-linux-gnu.tar.gz \
      && tar xzf wagerr*.tar.gz -C /usr/local/bin --strip-components 2 \
      && rm wagerr*.tar.gz

RUN useradd -u ${uid} -d /home/wagerr -rm wagerr
USER wagerr
WORKDIR /home/wagerr

RUN mkdir .wagerr
VOLUME /home/wagerr/.wagerr

EXPOSE 55002

CMD wagerrd -datadir=/home/wagerr/.wagerr -printtoconsole && wagerr-cli startmasternode local false

