from flask import jsonify

from src import app
from src.models.users import User

@app.route('/api/', methods=['GET'])
def index():
    users = []
    for user in User.objects:
        users.append(user)
    return jsonify({'message': 'Hello World!', 'users': users})
