import json

from flask import jsonify, request
from pandas import DataFrame
import numpy as np
from bson.objectid import ObjectId

from src import app, db_client

DAYS_IN_A_WEEK = 7
DAYS = {
    0: 'Monday',
    1: 'Tuesday',
    2: 'Wednesday',
    3: 'Thursday',
    4: 'Friday',
    5: 'Saturday',
    6: 'Sunday'
}


@app.route('/recipes', methods=['GET'])
def get_recipes():
    user_id = request.args.get('user_id')
    cooking_time_bound = request.args.get('cooking_time_bound')
    supermarkets = request.args.get('supermarket')
    if supermarkets:
        supermarkets = supermarkets.split(',')

    recipes = json.loads(generate_recipe(user_id))

    for i in range(len(recipes)):
        recipes[i]['day'] = DAYS[i % DAYS_IN_A_WEEK]

    return jsonify(recipes)


# matches recipes to ingredients. sorts them according to match ratio
def generate_recipe(user_id):
    product_collection = db_client['ingredients']
    recipe_collection = db_client['recipes']
    user_collection = db_client['user']

    products = product_collection.find({})
    recipes = recipe_collection.find({})
    user = user_collection.find_one({'_id': ObjectId(user_id)})

    recipe_lst = list(recipes)
    recipe_df = DataFrame(recipe_lst)
    recipe_df["ratio"] = np.nan

    # create a column of empty lists
    recipe_df["sale ingredient ids"] = np.empty((len(recipe_df), 0)).tolist()
    recipe_df["sale ingredients"] = np.empty((len(recipe_df), 0)).tolist()
    recipe_df["not on sale ingredients"] = np.empty((len(recipe_df), 0)).tolist()

    product_lst = list(products)
    for i in range(len(recipe_df)):
        if 'Vegan' in user['dietary_requirements'] and recipe_df.iloc[i]['vegan'] != True:
            recipe_df.loc[i, 'ratio'] = -1
            continue
        if 'Gluten-free' in user['dietary_requirements'] and recipe_df.iloc[i]['gluten_free'] != False:
            recipe_df.loc[i, 'ratio'] = -1
            continue
        for ingredient in recipe_df.iloc[i]['ingredients']:
            ingredient_words = ingredient['name'].split()
            if "stock" or "noodles" in ingredient_words:
                ingredient_words = [ingredient['name']]

            # iterate through products and match records with ingredient database
            for product in product_lst:
                match_found = False
                for word in ingredient_words:
                    if word in product['tags']:
                        recipe_df.iloc[i]["sale ingredient ids"].append(product['_id'])
                        recipe_df.iloc[i]["sale ingredients"].append(product['title'])
                        match_found = True
                        break
                if match_found:
                    break
            if not match_found:
                recipe_df.iloc[i]["not on sale ingredients"].append(ingredient['name'])

        recipe_df.loc[i, 'ratio'] = \
            len(recipe_df.loc[i]["sale ingredient ids"]) / len(recipe_df.iloc[i]['ingredients'])

    recipe_df = recipe_df.sort_values(by=['ratio'], ascending=False)

    meal_no = calculate_user_meal_no(user)["meals"]
    return recipe_df.iloc[0:meal_no].to_json(default_handler=str, orient='records')


def calculate_user_meal_no(user):
    if user['meal_option'] == "Everything":
        return {"breakfast": 1, "meals": 2 * DAYS_IN_A_WEEK}
    elif user['meal_option'] == 'No breakfast':
        return {"breakfast": 0, "meals": 2 * DAYS_IN_A_WEEK}
    else:
        return {"breakfast": 1, "meals": DAYS_IN_A_WEEK}
