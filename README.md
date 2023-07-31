## Instructions for Running Lumen in Docker

1. Install Docker and Docker Compose tools:
https://docs.docker.com/compose/install/

2. Configure environment variables, see instructions in sample.env

3. Build the containers:

   $> docker-compose up

4. Configure the database (first run):

    $> docker-compose run api bin/rails db:migrate

5. Host behind a reverse proxy to enable HTTPS

See https://wattsworth.net/lumen/index.html more information