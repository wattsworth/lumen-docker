## Instructions for Running Lumen in Docker

1. Install Docker and Docker Compose tools:
https://docs.docker.com/compose/install/

2. Configure environment variables, see instructions in sample.env

3. Build the containers:

   `$> docker compose up`

4. Configure the database (first run only, must be executed while containers are running and in the same directory as the compose file):

    `$> docker compose run lumen bin/rails db:migrate`

5. The site should be available at http://localhost:8080 assuming the default configuration in the compose file.
   
## Next Steps

**Add Joule Nodes:** Assuming Joule is running on the same machine and you are an authorized joule user, run the command:
    `$> joule master add lumen http://localhost:8080/lumen`

When adding the first node you will be prompted to create a new username and password, subsequent nodes will require an authorization token. Generate this token by clicking the "New Installation" button on the Lumen admin page.

**Host behind a reverse proxy to enable HTTPS:** Configuration files are provided in `/host`. The file `nginx-reverse-proxy.conf` provides a complete Nginx configuration. Just change the hostname and certificate information. If you want to host a Joule node on the same server these configurations can be merged by including the `nginx-joule` configuration and changing the user to `joule` which is required to access the Joule Unix sockets.

## Other Information
To rebuild the Lumen container see the `/container` directory.

See https://wattsworth.net/lumen/index.html for documentation on using the Lumen interface.
