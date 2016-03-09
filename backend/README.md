# MealprepBackend #

Backend for Mealprep service, written in [Elixir] using the [Phoenix Framework].

.. [Elixir]: http://elixir-lang.org/
.. [Phoenix Framework]: http://www.phoenixframework.org/

## Developing ##

To run in development mode, you need Docker Engine, Compose and Machine.

### Prerequisites ###

Before the backend can be run, you must download the deps:

```
$ dev mix hex.info
$ dev mix deps.get
```

Ecto is used e.g. to preseed the database, and the Postgres client `psql` is required for that. Therefore you must install Postgres so that `psql` ends up on your `$PATH`.

On Ubuntu, for example, it is enough to

```
$ sudo apt-get install postgresql-client
```

### OS X prerequisites ###

If you are on OS X, install [Homebrew] and then run

```
$ brew install docker docker-machine docker-compose
```

After this, you need a machine to run Docker containers in, because Docker Engine does not support OS X natively. I recommend a combination of [VirtualBox] and [Dinghy]. Install VirtualBox from the official image, and then run

```
$ brew install https://github.com/codekitchen/dinghy/raw/latest/dinghy.rb
```

Note that since Dinghy's formula is not in Homebrew itself, to upgrade you unfortunately have to uninstall, then reinstall.

.. [Homebrew]: http://brew.sh/
.. [VirtualBox]: https://virtualbox.org/
.. [Dinghy]: https://github.com/codekitchen/dinghy

### Running the backend ###

Use the `with-env` script to run your normal `mix` commands in the context of an environment:

```
$ ./with-env dev mix ecto.setup
$ ./with-env dev iex -S mix phoenix.server
```

## Food constituent data ##

The food constituent database is from the [National Institute for Health and Welfare, Fineli][Fineli], and used under the terms of the [Creative Commons Attribution 4.0 (CC-BY 4.0)][cc-by 4.0] licence.

.. [Fineli]: http://www.fineli.fi/
.. [cc-by 4.0]: https://creativecommons.org/licenses/by/4.0/

### Updating the data ###

Download the data ("Basic package" 1 or 2) from [Fineli's Open Data page][Fineli open data] and run:

```
$ ./update_seed_data.sh downloaded-fineli-data.zip
```

.. [Fineli open data]: http://www.fineli.fi/showpage.php?page=opendata
