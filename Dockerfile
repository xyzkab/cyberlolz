FROM ruby:2.4.3-slim-stretch

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
  build-essential vim wget gnupg2 curl libxml2 libxml2-dev \
  make zlib1g zlib1g-dev libreadline-dev \
  net-tools default-libmysqlclient-dev telnet git

ARG USER
ARG UID
ARG HOME=/home/$USER
ARG WORKDIR=/cyberlolz

RUN useradd -ms /bin/bash -u $UID $USER
WORKDIR $WORKDIR
COPY Gemfile $WORKDIR
RUN chown -R $USER $WORKDIR
USER $USER
RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc

ENV BUNDLE_PATH=$HOME/bundle \
    BUNDLE_BIN=$HOME/bundle/bin \
    GEM_HOME=$HOME/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN mkdir $BUNDLE_PATH && \
    chown -R $USER.$USER $BUNDLE_PATH
RUN bundle install

USER root
RUN rm -rf /var/lib/apt/lists/*

USER $USER
