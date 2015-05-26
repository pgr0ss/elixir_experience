FROM pgr0ss/elixir-docker-in-docker:d1.6.2_e1.0.4
MAINTAINER Paul Gross @pgr0ss

COPY . /code
WORKDIR /code

EXPOSE 4000

CMD ["/usr/local/bin/wrapdocker", "/code/prod.sh"]
