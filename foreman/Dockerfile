# Foreman container that can take any configuration for Kubernetes
FROM phusion/passenger-full:latest

ENV LANG en_US.utf8
ENV HOME /root
ENV FOREMAN_VERSION=1.13-stable

# From phusion passenger readme.  Enable nginx
RUN rm -f /etc/service/nginx/down

# Install some tools and dependencies
RUN apt-get update && apt-get install -y \
    git wget curl libvirt-dev postgresql openssl libsqlite-dev ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the default ruby version
RUN bash -lc 'rvm install ruby-2.3.6'
RUN bash -lc 'rvm --default use ruby-2.3.6'

# Install the nginx configuration
RUN rm /etc/nginx/sites-enabled/default                           
ADD foreman-nginx.conf /etc/nginx/sites-enabled/foreman-nginx.conf

# Install foreman from source
USER app
WORKDIR /home/app
RUN git clone https://github.com/theforeman/foreman.git -b ${FOREMAN_VERSION}

WORKDIR /home/app/foreman

#Place default database config
ADD ${PWD}/database.yml config/database.yml

# Place default foreman config for testing
RUN cp config/settings.yaml.example config/settings.yaml

# Install the foreman-xen plugin
RUN echo "gem 'foreman_xen'" > ./bundler.d/foreman_xen.rb  

# Install foreman and plugins
RUN gem install bundler
RUN bundle install
USER root
RUN npm install 

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
