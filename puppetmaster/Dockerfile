#FROM ruby:2.3-jessie
FROM debian:jessie

ADD https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb /puppetlabs.deb
RUN dpkg -i /puppetlabs.deb

RUN echo "deb http://deb.theforeman.org/ jessie 1.13" >> /etc/apt/sources.list.d/foreman.list
ADD https://deb.theforeman.org/pubkey.gpg /foreman-public.gpg
RUN apt-key add /foreman-public.gpg

ENV FOREMAN_VERSION=1.13-stable

RUN apt-get update && apt-get install -y \
    git \
    wget \
    ruby-dev \
    libffi-dev \
    libghc-augeas-dev \
    libvirt-dev \
    puppetserver \
    ca-certificates \
    puppetdb-terminus \
    ruby-dev \
    supervisor \
    foreman-proxy \
    && apt-get clean &&  rm -rf /var/lib/apt/lists/*

# Add the puppetserver.conf file and don't install stuff to /var/lib/puppet
RUN mkdir -p /var/lib/puppetserver/jruby-gems
ADD puppetserver.conf /etc/puppetserver/conf.d/puppetserver.conf

#Backport for https://github.com/puppetlabs/puppet/pull/4752
# 'ERF12-4115 [ProxyAPI::ProxyException]: Unable to get classes from Puppet for master Timed out reading data from server for proxy'
RUN sed -i 's/@hooks_to_call_on_application_initialization << setting/@hooks_to_call_on_application_initialization |= [ setting ]/g' \
  /usr/lib/ruby/vendor_ruby/puppet/settings.rb
RUN sed -i 's/@hooks_to_call_on_application_initialization << tryconfig/@hooks_to_call_on_application_initialization |= [ tryconfig ]/g' \
  /usr/lib/ruby/vendor_ruby/puppet/settings.rb

# Add prometheus as an exporter for puppet reports
ADD https://raw.githubusercontent.com/voxpupuli/puppet-prometheus_reporter/master/lib/puppet/reports/prometheus.rb /usr/lib/ruby/vendor_ruby/puppet/reports/prometheus.rb
RUN chmod 644 /usr/lib/ruby/vendor_ruby/puppet/reports/prometheus.rb

# Add the foreman reports processor
ADD https://raw.githubusercontent.com/theforeman/puppet-foreman/master/files/foreman-report_v2.rb /usr/lib/ruby/vendor_ruby/puppet/reports/foreman.rb
RUN chmod 644 /usr/lib/ruby/vendor_ruby/puppet/reports/foreman.rb

# Install the foreman proxy
#RUN git clone https://github.com/theforeman/smart-proxy.git -b ${FOREMAN_VERSION}
#WORKDIR /smart-proxy
#
## Change the version of puppet so that we don't break more stuff
#RUN sed -i 's/<\ 5\.0\.0/<=\ 3\.8\.7/' bundler.d/puppet.rb
#RUN bundle install

#Install the gpg-eyaml gems
RUN puppetserver gem install hiera hiera-eyaml hiera-eyaml-gpg ruby_gpg
RUN gem install hiera hiera-eyaml hiera-eyaml-gpg ruby_gpg

# Setup supervisord to run the proxy and master
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
