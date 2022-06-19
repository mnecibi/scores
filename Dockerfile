###
### Builder Stage
###
FROM elixir:1.13-alpine AS builder

RUN apk update --no-cache \
  && apk add --no-cache build-base openssh git

WORKDIR /app

RUN mix local.hex --force \
  && mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY lib lib
RUN mix compile

COPY priv priv
COPY assets assets
RUN mix assets.deploy

COPY config/runtime.exs config/
RUN mix release

###
### Final Stage - Separate image to keep it smaller
###
FROM alpine:3.16 AS app
RUN apk update --no-cache \
  && apk add --no-cache libstdc++ openssl ncurses-libs

ENV LANG=en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DATABASE_URL=ecto://postgres:postgres@127.0.0.1:5432/scores_dev
ENV SECRET_KEY_BASE=test

WORKDIR /app
RUN chown nobody /app

COPY --from=builder --chown=nobody:root /app/_build/prod/rel ./

USER nobody:nobody

RUN set -eux; \
  ln -nfs /app/$(basename *)/bin/$(basename *) /app/entry

CMD ["sh", "-c", "/app/entry eval Scores.Release.migrate && /app/entry start"]