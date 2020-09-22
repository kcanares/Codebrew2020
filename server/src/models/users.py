import datetime

from src import db

class User(db.Document):
    name = db.StringField(max_length=200)
    created = db.DateTimeField(default=datetime.datetime.now)
