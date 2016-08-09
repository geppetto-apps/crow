FROM geppettoapps/crystal-libxml2:0.18.7
MAINTAINER Theodor Tonum <theodor@tonum.no>
ENV REFRESHED_AT 2016-08-05

RUN mkdir /app
WORKDIR /app

COPY shard.* ./
RUN shards install

RUN mkdir build
COPY src ./src/
COPY spec ./spec/

CMD ["crystal", "spec"]
