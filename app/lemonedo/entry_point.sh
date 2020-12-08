#!/bin/bash

set -e

echo "${0}: running migrations."
python manage.py makemigrations --merge
python manage.py migrate --noinput

echo "${0}: collecting statics."

python manage.py collectstatic --noinput

cp -rv lemonedo/static/* lemonedo/static_shared/

gunicorn lemonedo.asgi:application -k uvicorn.workers.UvicornWorker \
    --env DJANGO_SETTINGS_MODULE=lemonedo.settings \
    --name lemonedo \
    --bind 0.0.0.0:8000 \
    --timeout 600 \
    --workers 2 \
    --log-level=info \
    --reload