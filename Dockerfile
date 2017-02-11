FROM geppettoapps/crystal-libxml2:0.20.5
MAINTAINER Theodor Tonum <theodor@tonum.no>
ENV REFRESHED_AT 2017-02-11

RUN mkdir /app
WORKDIR /app

COPY shard.yml ./
RUN shards install

RUN mkdir build
RUN mkdir npm
COPY src ./src/
COPY spec ./spec/
COPY examples ./examples/
COPY bin ./bin/

RUN crystal spec
RUN bin/build

ENTRYPOINT ["build/crow"]
