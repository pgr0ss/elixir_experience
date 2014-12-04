FROM trenpixster/elixir
MAINTAINER Paul Gross @pgr0ss

ADD . /code
WORKDIR /code

# Install Docker
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
  && apt-get update -qq \
  && apt-get install -qqy lxc-docker

# Install the docker in docker wrapper
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Make docker location a volume
VOLUME /var/lib/docker

EXPOSE 4000
CMD ["/usr/local/bin/wrapdocker", "mix do deps.get, phoenix.start"]
