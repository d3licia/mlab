FROM ruby:2.4.2

WORKDIR /app

RUN apt-get update && \
    apt-get -y install libpq-dev && \
    gem install bundler

COPY . /app

RUN bundle install --system && \
    rm -rf ~/.gem /root/.bundle/cache /usr/local/bundle/cache
