FROM ruby:3.4.7-slim

RUN apt-get update && apt-get install -y git ruby-dev build-essential && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . . 