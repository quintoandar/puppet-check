FROM        ubuntu:bionic

LABEL       version="1.0"
LABEL       mantainer="Caio Delgado"
LABEL       team="SRE"
LABEL       enterprise="QuintoAndar"

ADD         http://apt.puppetlabs.com/puppet6-release-bionic.deb /tmp/puppet.deb

RUN         dpkg -i /tmp/puppet.deb && apt-get update \
            && DEBIAN_FRONTEND=noninteractive apt-get install -y puppet puppet-lint \
            && rm -rf /var/cache/apt/* && rm -rf /tmp/*

COPY        entrypoint.sh /usr/bin/entrypoint.sh

RUN         ["chmod", "+x", "/usr/bin/entrypoint.sh"]

VOLUME      [ "/manifests" ]
ENTRYPOINT  ["/usr/bin/entrypoint.sh"]
CMD         ["--help"]