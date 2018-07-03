FROM debian:stable-slim

LABEL maintainer="lukogex"

RUN apt-get update \
      && apt-get install -y --no-install-recommends ca-certificates wget \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wagerr/wagerr/releases/download/1.5.0/wagerr-1.5.0-x86_64-linux-gnu.tar.gz \
      && tar xzf wagerr*.tar.gz -C /usr/local/bin --strip-components 2 \
      && rm wagerr*.tar.gz

RUN useradd -d /home/wagerr -ms /bin/bash wagerr
USER wagerr
WORKDIR /home/wagerr

RUN mkdir .wagerr
VOLUME /home/wagerr/.wagerr

EXPOSE 55002

CMD wagerrd -datadir=/home/wagerr/.wagerr -printtoconsole && wagerr-cli startmasternode local false

