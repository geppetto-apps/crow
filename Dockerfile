FROM geppettoapps/crystal-libxml2:0.18.7
MAINTAINER Theodor Tonum <theodor@tonum.no>
ENV REFRESHED_AT 2016-08-05

RUN git clone https://github.com/crystal-lang/crystal.git /crystal

RUN mkdir /app
WORKDIR /app

COPY shard.yml ./
RUN shards install

RUN mkdir build
COPY src ./src/
COPY bin ./bin/

RUN crystal spec
RUN bin/build

ENTRYPOINT ["build/cr2flow"]
