# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile

FROM ruby:2.7.6-alpine

RUN apk add --update --no-cache  --virtual run-dependencies \
build-base \
sqlite-dev \ 
yarn \
git \
tzdata \
libpq \
&& rm -rf /var/cache/apk/*

ENV RAILS_ROOT /var/www/
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install

COPY . .

ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000

