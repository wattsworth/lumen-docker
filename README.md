## Instructions for Running Lumen in Docker

1. Install Docker and Docker Compose tools:
https://docs.docker.com/compose/install/

2. Build the containers:

   $> docker-compose up

3. Configure the database (first run):

    $> docker-compose run api bin/rails db:migrate

See https://wattsworth.net/lumen/index.html more information