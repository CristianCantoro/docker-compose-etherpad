# An etherpad instance deployed with docker compose

This is a `docker-compose` file for Etherpad. It builds on the existing [`Dockerfile`](https://github.com/ether/etherpad-lite/blob/2.2.7/docker-compose.yml) that can be found at [etherpad-lite](https://github.com/ether/etherpad-lite).

This compose file will start up two containers: a PostgreSQL container and an Etherpad container configured to use Postgres, listening on port 9001. SSL is left unconfigured, with the intention of putting this behind Apache or nginx.

## Customising

The default configuration for Postgres sets up a database named `etherpad`, with a user of `etherpad` and a password of `changeme`. To change this:

* update the configuration in settings.json (the `dbSettings` section);
* update the configuration in `docker-compose` (the `POSTGRES_*` variables);
* rebuild the Etherpad image with `docker-compose build`

For more information, consult the Etherpad documentation at
[etherpad-lite > wiki](https://github.com/ether/etherpad-lite/wiki/).
