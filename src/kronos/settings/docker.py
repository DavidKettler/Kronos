import os

from src.kronos.settings import *
from src.kronos.settings import secrets

# Allowed hosts for Dev enviornment 
ALLOWED_HOSTS = [
    '127.0.0.1',
    'localhost',
]
INTERNAL_IPS = ['127.0.0.1']

# I want to use postgresql for my database buisness
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME':  os.getenv('POSTGRES_NAME', 'kronos'),
        'USER': os.getenv('POSTGRES_USER'),
        'PASSWORD': os.getenv('POSTGRES_PASSWORD'),
        'HOST': os.getenv('POSTGRES_HOST', '127.0.0.1'),
        'PORT': os.getenv('POSTGRES_PORT', '5432'),
    },
}

CACHES = { 
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }   
}

# We want debug mode
DEBUG = True

STATIC_URL = '/src/agartha/static/'