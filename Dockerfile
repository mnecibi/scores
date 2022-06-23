###
### Builder Stage
###
FROM elixir:1.13-alpine AS builder

RUN apk update --no-cache \
  && apk add --no-cache build-base openssh git nodejs npm

WORKDIR /app

RUN mix local.hex --force \
  && mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY priv priv

COPY lib lib

COPY assets assets

# compile assets
RUN mix assets.deploy

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

RUN MIX_ENV=prod mix release

###
### Final Stage - Separate image to keep it smaller
###
FROM alpine:3.16 AS app
RUN apk update --no-cache \
  && apk add --no-cache libstdc++ openssl ncurses-libs

ENV LANG=en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/scores ./

USER nobody

CMD ["sh", "-c", "/app/bin/scores eval Scores.Release.migrate ; /app/bin/scores start"]