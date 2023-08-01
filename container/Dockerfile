ARG RUBY_VERSION=3.2.0

FROM node:18 as node
WORKDIR /app
RUN git clone https://github.com/wattsworth/lumen-client.git /app
RUN npm install
RUN npm run build --omit=dev

FROM phusion/passenger-ruby32
# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips gnupg2 curl git pkg-config postgresql-client libpq-dev nginx gettext

# Upgrade container to the latest version
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

COPY --from=node /app/dist/lumen /usr/share/nginx/html

# Ensure node.js 18 is available for apt-get
ARG NODE_MAJOR=18
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install node and yarn
RUN apt-get update -qq && apt-get install -y nodejs && npm install -g yarn

# Mount $PWD to this workdir
WORKDIR /home/app
ENV APP_DIR=/home/app


# Install Rails
RUN gem install rails bundler

# Copy in the application
USER app
RUN git init
RUN git remote add origin https://github.com/wattsworth/lumen-api.git
RUN git fetch
RUN git checkout origin/master -ft
ENV BUNDLER_WITHOUT development test
USER root
RUN bundle install

# Copy in the custom configuration files
USER app
COPY api/production_config.rb $APP_DIR/config/environments/production.rb
COPY api/database.yml $APP_DIR/config/database.yml
COPY api/secrets.yml $APP_DIR/config/secrets.yml
COPY api/smtp_initializer.rb $APP_DIR/config/initializers/smtp_init.rb

# Set the ownership to app user
USER root
RUN chown -R app:app $APP_DIR

# Copy in the nginx configuration files

ADD nginx/lumen.conf /etc/nginx/templates/lumen.conf.template
RUN rm /etc/nginx/sites-enabled/default
COPY scripts/* /etc/my_init.d
RUN chmod +x /etc/my_init.d/*
# Set the environment to production
ENV RAILS_ENV=production

# Set the custom environment variables
ENV SEND_EMAILS=false
#ENV SMTP_ADDRESS=smtp.gmail.com
#ENV SMTP_PORT=587
#ENV SMTP_DOMAIN=example.com
#ENV SMTP_USERNAME="test"
#ENV SMTP_PASSWORD="test"
#ENV SMTP_AUTHENTICATION=plain
#ENV SMTP_ENABLE_STARTTLS_AUTO=true

# --CHANGE THIS VALUE IN PRODUCTION!--
ENV SECRET_KEY_BASE="dea552246b8c55bc73e3b8a587f04966d1ed7b35d81341ced18263823867ac95"

ENV DATABASE_HOST="postgres"
ENV DATABASE_NAME="rails"
ENV DATABASE_USERNAME="rails"
ENV DATABASE_PASSWORD="rails"

ENV BANNER="Lumen Docked"

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable Nginx and Passenger
RUN rm -f /etc/service/nginx/down
