FROM debian:jessie

# set workdir
WORKDIR /

# install requirements
RUN apt-get update \
  && apt-get install -y python python-pip curl git \
     gcc libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev \
  && pip install --upgrade pip \
  && pip install --upgrade appdirs cffi pyparsing lxml pyOpenSSL j2cli \
  && apt-get remove --purge -y gcc libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev \
  && rm -rf /var/lib/apt/lists/*

# download sabnzbd and nzbtomedia
RUN git clone https://github.com/CouchPotato/CouchPotatoServer.git

# copy the couchpotato configuration file
ADD build/settings.conf /CouchPotatoServer/settings.conf
# add the entry script
ADD build/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# run the docker entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
