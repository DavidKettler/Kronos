from src.kronos.settings import *

from src.kronos.settings.secrets import dev_postgres_user
from src.kronos.settings.secrets import dev_postgres_pass

# Allowed hosts for Dev enviornment 
ALLOWED_HOSTS = ['www.example.com', '127.0.0.1', '10.1.2.8']

# I want to use postgresql for my database buisness 😊
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'kronos',
        'USER': dev_postgres_user,
        'PASSWORD': dev_postgres_pass,
        'HOST': '127.0.0.1',
        'PORT': '5432',
    },
}

CACHES = { 
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }   
}
