FROM ruby:2.3-alpine

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2 libxml2-dev libxslt-dev tzdata yaml-dev postgresql postgresql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs"

RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install --without test development && bundle clean

COPY . /usr/src/app

RUN RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]