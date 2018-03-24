FROM debian: jessie

ADD https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb /puppetlabs.deb
RUN dpkg -i /puppetlabs.deb

RUN apt-get update && apt-get install -y \
    puppetserver \
    && apt-get clean

CMD puppet master --verbose --no-daemonize
