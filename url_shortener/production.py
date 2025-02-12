from . import settings  # Import base settings from settings.py

# Turn off debug mode in production
DEBUG = False

# Set the allowed hosts (you should set this to your domain name or public IP address)
ALLOWED_HOSTS = []

# Use a more secure database like PostgreSQL, MySQL, etc.
# You can set this from environment variables, but here's an example of using PostgreSQL
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Static files (ensure this is set up for production)
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

# Media files (for uploaded content)
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# Use a more secure secret key (you should set this as an environment variable)
SECRET_KEY = 'django-insecure-h6i2mz0ityv87h4jezm)xbt_2!_-!j)nv(oh#%3kwsl9nf!tkt'

# Other production-specific settings (e.g., logging, email settings, etc.)
# For example, use an SMTP server for sending emails in production
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.mailgun.org'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = 'your-email@example.com'
EMAIL_HOST_PASSWORD = 'your-email-password'

# Optional: Configure logging to track errors in production
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': 'DEBUG',
            'propagate': True,
        },
    },
}
