import json

from flask import jsonify
from bson.json_util import dumps

from src import app, db_client


@app.route('/ingredients', methods=['GET'])
def get_ingredients():
    collection = db_client['ingredients']
    cursor = collection.find({})
    ingredients = []
    for document in cursor:
        ingredients.append(document)

    return jsonify(json.loads(dumps(ingredients)))
