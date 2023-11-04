FROM ruby:3.2.2-alpine as base

RUN apk update && apk add --no-cache git build-base

ENV WORKDIR /usr/src

RUN mkdir -p $WORKDIR

WORKDIR $WORKDIR

COPY ./ $WORKDIR

RUN bundle install
# 

FROM base as development

CMD ["irb", "-r", "/usr/src/lib/bunnier"]
