import os

class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'app-secret-key'
    MONGODB_SETTINGS = {
        'db': os.environ.get('MONGO_DB_NAME') or 'codebrew2020',
        'host': os.environ.get('MONGO_DB_HOST') or 'db',
        'port': int(os.environ.get('MONGO_PORT')) or 27017
    }
