FROM ruby:2.3-jessie
# Foreman 1.13 is only comapatible with ruby 2.3

ENV FOREMAN_VERSION=1.13-stable

RUN apt-get update && apt-get install -y \
    git \
    wget \
    ca-certificates \
    ruby-dev libffi-dev \
    libghc-augeas-dev \
    libvirt-dev \
    && rm -rf /var/lib/apt/lists/*

RUN  wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb
RUN dpkg -i dumb-init_1.2.1_amd64.deb

RUN git clone https://github.com/theforeman/smart-proxy.git -b ${FOREMAN_VERSION}
WORKDIR /smart-proxy
RUN bundle install

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/smart-proxy/bin/smart-proxy"]
