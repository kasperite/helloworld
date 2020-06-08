FROM ruby:2.5.8-stretch

ENV NODE_VERSION v12.16.3
ENV DISTRO linux-x64

RUN mkdir -p /usr/local/lib/nodejs
RUN apt-get update && apt-get install -y curl xz-utils && rm -rf /var/lib/apt/lists/*
RUN curl -o /tmp/node-$NODE_VERSION-$DISTRO.tar.xz https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-$DISTRO.tar.xz
RUN tar -xJvf /tmp/node-$NODE_VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs

ENV PATH /usr/local/lib/nodejs/node-$NODE_VERSION-$DISTRO/bin:$PATH

WORKDIR /app

ADD . /app

RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]