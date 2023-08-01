## Instructions for Running Lumen in Docker

1. Install Docker and Docker Compose tools:
https://docs.docker.com/compose/install/

2. Configure environment variables, see instructions in sample.env

3. Build the containers:

   $> docker compose up

4. Configure the database (first run):

    $> docker compose run lumen bin/rails db:migrate

5. Host behind a reverse proxy to enable HTTPS. Configuration files are provided in `/host`. The file `nginx-reverse-proxy.conf` provides a complete Nginx configuration. Just change the hostname and certificate information. If you want to host a Joule node on the same server these configurations can be merged by including the `nginx-joule` configuration and changing the user to `joule` which is required to access the Joule Unix sockets.

To rebuild the Lumen container see the `/container` directory.

See https://wattsworth.net/lumen/index.html more information
