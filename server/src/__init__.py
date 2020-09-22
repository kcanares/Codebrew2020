import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_cors import CORS
from flask_mongoengine import MongoEngine

from .config import Config

db = MongoEngine()
app = Flask(__name__)
CORS(app)
app.config.from_object(Config)
db.init_app(app)

from .routes import *
from .models import *
