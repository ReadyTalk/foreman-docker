FROM debian:jessie

ADD https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb /puppetlabs.deb
RUN dpkg -i /puppetlabs.deb

RUN apt-get update && apt-get install -y \
    git \
    wget \
    puppetserver \
    ca-certificates \
    ruby-dev \
    && apt-get clean

# Install dumb-init
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb
RUN dpkg -i dumb-init_1.2.1_amd64.deb

#Install the gpg-eyaml gems
RUN gem install hiera-eyaml hiera-eyaml-gpg gpgme && gem install ruby_gpg -v ">=0.3.1"

#Backport for https://github.com/puppetlabs/puppet/pull/4752
# 'ERF12-4115 [ProxyAPI::ProxyException]: Unable to get classes from Puppet for master Timed out reading data from server for proxy'
RUN sed -i 's/@hooks_to_call_on_application_initialization << setting/@hooks_to_call_on_application_initialization |= [ setting ]/g' \
  /usr/lib/ruby/vendor_ruby/puppet/settings.rb
RUN sed -i 's/@hooks_to_call_on_application_initialization << tryconfig/@hooks_to_call_on_application_initialization |= [ tryconfig ]/g' \
  /usr/lib/ruby/vendor_ruby/puppet/settings.rb

#Add prometheus as an exporter for puppet reports
ADD https://raw.githubusercontent.com/voxpupuli/puppet-prometheus_reporter/master/lib/puppet/reports/prometheus.rb /usr/lib/ruby/vendor_ruby/puppet/reports/prometheus.rb
RUN chmod 644 /usr/lib/ruby/vendor_ruby/puppet/reports/prometheus.rb

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/usr/bin/puppet", "master", "--verbose", "--no-daemonize"]
