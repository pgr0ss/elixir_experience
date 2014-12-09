FROM pgr0ss/elixir-docker-in-docker
MAINTAINER Paul Gross @pgr0ss

COPY . /code
WORKDIR /code

EXPOSE 4000
CMD ["/usr/local/bin/wrapdocker", "mix do deps.get, phoenix.start"]
