FROM ruby:3.2.2
ENV LANG C.UTF-8

RUN apt-get install
ENV APP_ROOT /usr/src/client

WORKDIR $APP_ROOT

RUN apt-get dist-upgrade && \
    apt-get update && \
    apt-get install -y libpq-dev \
        build-essential \
        ruby-dev \
        curl \
        lsb-release \
        wget \
        gnupg2 \
        --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /bundle

ENV BUNDLE_PATHBUNDLE_PATH /bundle
ENV GEM_HOME /bundle
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1
ENV RUBY_YJIT_ENABLE 1
