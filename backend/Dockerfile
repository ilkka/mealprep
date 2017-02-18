FROM msaraiva/elixir-dev

RUN mkdir -p /app
WORKDIR /app
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile
ADD . ./
ARG cookie
ENV COOKIE=$cookie
ENV PORT=80
EXPOSE 80
RUN MIX_ENV=prod mix do compile, phoenix.digest, release --env=prod

CMD ["./rel/mealprep_backend/bin/mealprep_backend", "foreground"]
