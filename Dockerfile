FROM elixir:1.7.3

ENV DEBIAN_FRONTEND=noninteractive
ENV ELIXIR_VERSION="v1.12.3" \
    LANG=C.UTF-8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vim nano curl wget && \
    mkdir /elixir-home

WORKDIR /elixir-home

CMD ["iex"]