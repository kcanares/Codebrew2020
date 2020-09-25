import json

from flask import jsonify
from bson.json_util import dumps

from src import app, db_client


@app.route('/recipes', methods=['GET'])
def get_recipes():
    collection = db_client['recipes']
    cursor = collection.find({})
    recipes = []
    for document in cursor:
        recipes.append(document)

    return jsonify(json.loads(dumps(recipes)))
