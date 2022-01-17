FROM python:3.8 as base

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONPATH=/app/kronos/src/:$PYTHONPATH
ENV DJANGO_SETTINGS_MODULE=src.kronos.settings.docker
ENV DEBUG="${DEBUG}"
ENV PIPENV_VENV_IN_PROJECT=1

# update the system
RUN apt update
RUN apt upgrade -y
RUN apt install --fix-missing -y postgresql-client postgresql-client-common build-essential python-dev python-dev curl git
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs --no-install-recommends

# Create the user & dir permissions
RUN useradd -ms /bin/bash kronos
RUN mkdir -p /app/Kronos
RUN chown kronos:kronos /app/Kronos/

# Upgrade pip
RUN pip install --upgrade pip
# RUN pip install pipenv

USER kronos
WORKDIR /app/Kronos/

# Copy all files base files over
COPY --chown=kronos ./manage.py /app/Kronos/
COPY --chown=kronos ./requirements.txt /app/Kronos/
# COPY --chown=kronos ./Pipfile /app/Kronos/
# COPY --chown=kronos ./Pipfile.lock /app/Kronos/
COPY --chown=kronos ./entrypoint.sh /app/Kronos/
COPY --chown=kronos ./src /app/Kronos/src

# RUN pipenv sync
# RUN mkdir -v /app/Kronos/venv
# COPY /app/.venv/ /app/Kronos/venv/
# RUN export VENV_PATH="$(pipenv --venv)"
# RUN export PYTHONPATH="${VENV_PATH}/bin/python"

RUN python -m venv /app/Kronos/ve
RUN . /app/Kronos/ve/bin/activate && python -m pip install -r requirements.txt

RUN . /app/Kronos/ve/bin/activate && python manage.py tailwind install --no-input;
RUN chmod -R a+x src/agartha/static_src/node_modules
RUN chown -R kronos:kronos ~/.npm
# RUN pipenv run python3 manage.py tailwind build --no-input;
# RUN pipenv run python3 manage.py collectstatic --no-input;

FROM base as local
EXPOSE 8000 8383
# ENTRYPOINT ["/app/Kronos/entrypoint.sh"]
# CMD pipenv run python3 manage.py runserver 0.0.0.0:8000
