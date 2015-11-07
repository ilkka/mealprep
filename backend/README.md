# MealprepBackend

This is the backend for Mealprep, written using the [Phoenix Framework].

[Phoenix Framework]: http://www.phoenixframework.org/

## Development

To run in development mode, Docker, Docker Compose and Docker Machine are required, along with Phoenix Framework itself. When the prerequisites are installed, run:

    $ ./start_development_environment.sh

and you should get an `iex` session with the backend running on port 4000.

To remove data stored during development, remove the database container:

    $ docker-compose rm -f
