FROM ruby:2.3-alpine
# Foreman 1.13 is only comapatible with ruby 2.3

ENV FOREMAN_VERSION=1.13-stable

RUN apk add --update \
    git \
    ca-certificates \
    clang make ruby-dev libffi-dev \
    && rm -rf /var/cache/apk/*

RUN git clone https://github.com/theforeman/smart-proxy.git -b ${FOREMAN_VERSION}
WORKDIR /smart-proxy
RUN bundle install
