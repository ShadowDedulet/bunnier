FROM ruby:3.2.2-alpine as base

RUN apk add --no-cache git build-base

ENV WORKDIR /usr/src

RUN mkdir -p $WORKDIR

WORKDIR $WORKDIR

COPY ./ $WORKDIR

# 

FROM base as development

RUN bundle install

CMD ash
