FROM debian:buster-slim

# Install Apache2 and utilities
RUN apt-get update && apt-get install -y \
    apache2 \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

# Set the server name
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable modules
RUN a2enmod rewrite auth_basic

# Create the custom volume for /var/www/html
VOLUME /var/www/html

# Set environment variables for username and password
ENV AUTH_USERNAME='username'
ENV AUTH_PASSWORD='password'

# Override the default values if environment variables are set at runtime
ARG AUTH_USERNAME
ARG AUTH_PASSWORD
ENV AUTH_USERNAME=${AUTH_USERNAME:-$AUTH_USERNAME}
ENV AUTH_PASSWORD=${PASSWORD:-$AUTH_PASSWORD}
# Create the htpasswd file with the specified username and password

# Copy the Apache2 configuration file with basic authentication enabled
COPY apache2.conf /etc/apache2/sites-available/000-default.conf

# Expose the default Apache2 port
EXPOSE 80

# Start Apache2 in the foregroun
CMD sh -c 'if [ -e /etc/apache2/.htpasswd ]; then \
             rm -rf /etc/apache2/.htpasswd; \
         fi && htpasswd -b -c /etc/apache2/.htpasswd $AUTH_USERNAME $AUTH_PASSWORD && apache2ctl -D FOREGROUND'