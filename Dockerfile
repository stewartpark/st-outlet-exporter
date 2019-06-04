FROM node:8.16-jessie
MAINTAINER Stewart Park <hello@stewartjpark.com>

RUN apt-get update && \
    apt-get install -y git-core busybox && \
    git clone https://github.com/SmartThingsCommunity/cli-example-nodejs /cli && \
    cd /cli && npm install

WORKDIR /cli
COPY docker-entrypoint.sh /
ENTRYPOINT /docker-entrypoint.sh
