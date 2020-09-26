from flask import jsonify, request

from src import app
from src.models.user import User


@app.route('/users/signup', methods=['POST'])
def sign_up():
    data = request.get_json()
    user = User(
        email=data['email'],
        password=data['password'],
        name=data['name'],
        dietary_requirements=data['dietary_requirements'],
        meal_option=data['meal_option']
    )
    user.save()

    return jsonify(user)


@app.route('/users/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.objects(
        email=data['email'],
        password=data['password']
    ).first()

    if not user:
        return jsonify({'error_message': 'The user does not exist'}), 401

    return jsonify(user)


@app.route('/users/<user_id>', methods=['GET'])
def get_user(user_id):
    user = User.objects(
        pk=user_id
    ).first()

    if not user:
        return jsonify({'error_message': 'The user does not exist'}), 404

    return jsonify(user)


@app.route('/users/<user_id>', methods=['PUT'])
def update_user(user_id):
    user = User.objects(
        pk=user_id
    ).first()

    if not user:
        return jsonify({'error_message': 'The user does not exist'}), 404

    data = request.get_json()
    if 'name' in data:
        user.name = data['name']
    if 'dietary_requirements' in data:
        user.dietary_requirements = data['dietary_requirements']
    if 'meal_option' in data:
        user.meal_option = data['meal_option']

    user.save()

    return jsonify(user)
