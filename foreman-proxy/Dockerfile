FROM ruby:2.3-jessie
# Foreman 1.13 is only comapatible with ruby 2.3

ENV FOREMAN_VERSION=1.13-stable

RUN apt-get update && apt-get install -y \
    git \
    ca-certificates \
    ruby-dev libffi-dev \
    libghc-augeas-dev \
    libvirt-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/theforeman/smart-proxy.git -b ${FOREMAN_VERSION}
WORKDIR /smart-proxy
RUN bundle install
