FROM debian:jessie

# Install puppetlabs-release
ADD https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb /puppetlabs.deb
RUN dpkg -i /puppetlabs.deb

#Install Software
RUN apt-get update && apt-get install -y \
    locales \
    ca-certificates \
    puppetdb \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get clean

ENV LANG en_US.utf8

#Add the default files and certs.  Reset ownership
ADD conf/database.ini /etc/puppetdb/conf.d/database.ini
ADD conf/logback.xml /etc/puppetdb/logback.xml
ADD conf/jetty.ini /etc/puppetdb/conf.d/jetty.ini

# Increase available ram
RUN sed -i "s/Xmx192m/Xmx512m/g" /etc/default/puppetdb

CMD [ "/usr/sbin/puppetdb", "foreground" ]
