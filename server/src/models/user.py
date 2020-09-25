from src import db


class User(db.Document):
    email = db.StringField(max_length=200)
    name = db.StringField(max_length=200)
    password = db.StringField(max_length=200)
