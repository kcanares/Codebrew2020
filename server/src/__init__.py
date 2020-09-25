import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_cors import CORS
from flask_mongoengine import MongoEngine
from pymongo import MongoClient

from .config import Config

app = Flask(__name__)
CORS(app)
app.config.from_object(Config)


client = MongoClient('mongodb://165.22.254.55:27017/')
db = client['codebrew2020']

from .routes import *
from .models import *
