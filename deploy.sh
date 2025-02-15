#!/usr/bin/env bash

cd /var/www/django_app

# Activate virtual environment (if applicable)
source venv/bin/activate

# Start Django app
gunicorn url_shortener.wsgi:application --bind 0.0.0.0:3000 --workers 3

# Restart NGINX
systemctl restart nginx
