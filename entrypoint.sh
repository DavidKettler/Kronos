#!/usr/bin/env sh

run_migrations() {
    echo "Running migrations"
    pipenv run python manage.py migrate --no-input
}

_main() {
    cd /app/kronos/
    run_migrations
    echo "Starting Server 🚀"
    exec "$@"
}

_main "$@"
