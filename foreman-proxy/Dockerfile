FROM debian:8-slim

ENV FOREMAN_VERSION=1.13-stable

RUN apt-get update && apt-get install -y \
    git \
    ca-certificates \
    && apt-get clean

RUN git clone https://github.com/theforeman/smart-proxy.git -b ${FOREMAN_VERSION}

