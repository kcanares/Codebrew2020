import json
import random
from collections import defaultdict

from flask import jsonify, request
from pandas import DataFrame
import numpy as np
from bson.objectid import ObjectId
from bson.json_util import dumps

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
    params = request.args

    recipe_df = generate_recipe(user_id, params)
    tally_dict, savings = tally_ingredients(recipe_df)

    recipes = json.loads(insert_breakfast(recipe_df).to_json(default_handler=str, orient='records'))
    breakfast = recipes.pop()

    for i in range(len(recipes)):
        recipes[i]['day'] = DAYS[i % DAYS_IN_A_WEEK]
        recipes[i]['servings'] = random.randint(1, 5)

    return jsonify({
        'meals': recipes,
        'breakfast': breakfast,
        'ingredients': json.loads(dumps(tally_dict)),
        'savings': savings
    })


# matches recipes to ingredients. sorts them according to match ratio
def generate_recipe(user_id, params):
    product_collection = db_client['ingredients']
    recipe_collection = db_client['recipes']
    user_collection = db_client['user']

    # Params
    cooking_time_bound = params.get('cooking_time_bound')
    supermarkets = params.get('supermarket')
    if supermarkets:
        supermarkets = supermarkets.split(',')

    products = product_collection.find({})
    recipes = recipe_collection.find({})
    user = user_collection.find_one({'_id': ObjectId('5f6e7fdf20993e3adbef5535')})

    recipe_lst = list(recipes)
    recipe_df = DataFrame(recipe_lst)
    recipe_df["ratio"] = np.nan

    # create a column of empty lists
    recipe_df["sale ingredient ids"] = np.empty((len(recipe_df), 0)).tolist()
    recipe_df["sale ingredients"] = np.empty((len(recipe_df), 0)).tolist()
    recipe_df["non sale ingredients"] = np.empty((len(recipe_df), 0)).tolist()

    product_lst =list(products)
    for i in range(len(recipe_df)):
        for ingredient in recipe_df.iloc[i]['ingredients']:
            if 'Vegan' in user['dietary_requirements'] and recipe_df.iloc[i]['vegan'] != True:
                recipe_df.loc[i, 'ratio'] = -1
                continue
            if 'Gluten-free' in user['dietary_requirements'] and recipe_df.iloc[i]['gluten_free'] != False:
                recipe_df.loc[i, 'ratio'] = -1
                continue
            if cooking_time_bound and recipe_df.iloc[i]['cook_time'] < int(cooking_time_bound):
                recipe_df.loc[i, 'ratio'] = -1
                continue

            ingredient_words = ingredient['name'].split()
            if "stock" or "noodles" in ingredient_words:
                ingredient_words = [ingredient['name']]

            # iterate through products and match records with ingredient database
            for product in product_lst:
                match_found = False
                for word in ingredient_words:
                    if word in product['tags']:
                        # print(product['title'], ingredient['name'], product['tags'])
                        recipe_df.iloc[i]["sale ingredient ids"].append(product['_id'])
                        recipe_df.iloc[i]["sale ingredients"].append({"id": product['_id'],
                                                                      "quantity": ingredient['quantity'],
                                                                      "measurement": ingredient['measurement']})
                        match_found = True
                        break
                if match_found:
                    break
            if not match_found:
                recipe_df.iloc[i]["non sale ingredients"].append(ingredient)

        recipe_df.loc[i, 'ratio'] = \
            len(recipe_df.loc[i]["sale ingredient ids"]) / len(recipe_df.iloc[i]['ingredients'])

    recipe_df = recipe_df.sort_values(by=['ratio'], ascending=False)

    meal_no = calculate_user_meal_no(user)["meals"]
    return recipe_df.iloc[:meal_no][:].reset_index(drop=True)


def calculate_user_meal_no(user):
    if user['meal_option'] == "Everything":
        return {"breakfast": 1, "meals": 2 * DAYS_IN_A_WEEK}
    elif user['meal_option'] == 'No breakfast':
        return {"breakfast": 0, "meals": 2 * DAYS_IN_A_WEEK}
    else:
        return {"breakfast": 1, "meals": DAYS_IN_A_WEEK}


def insert_breakfast(recipe_df):
    """"gets cheapest breakfast and puts it in the recipe_df"""
    CEREAL_URL = 'https://www.woolworths.com.au/shop/productdetails/827588/uncle-tobys-cereal-plus-iron'

    product_collection = db_client['ingredients']
    products = product_collection.find({})
    product_lst = list(products)
    cheapest_cereal = None
    cheapest_milk = None
    for product in product_lst:
        if 'breakfast' in product['tags']:
            if cheapest_cereal is None or product["price"] < cheapest_cereal["price"]:
                cheapest_cereal = product
        if 'breakfast milk' in product['tags']:
            if cheapest_milk is None or product["price"] < cheapest_milk["price"]:
                cheapest_milk = product

    recipe_df.loc[len(recipe_df)] = ['BREAKFAST', {'kcal': 155, 'fat': 2.3, 'saturates': 20.0, 'carbs':28.6, 'sugars': 7, 'fibre': 5.0, 'protein': 3.4, 'salt': 78},
                      [cheapest_cereal, cheapest_milk], np.NaN, ['breakfast'], cheapest_cereal['title'],CEREAL_URL
                      , 2, 0, np.NaN, np.NaN, 1,
                    [cheapest_cereal['_id'], cheapest_milk['_id']],
                      [{'id': cheapest_cereal['_id'], 'value': cheapest_cereal['amount'][0]['value'], 'quantity': cheapest_cereal['amount'][0]['measurement']},
                                                    {'id': cheapest_milk['_id'],
                                                     'value': cheapest_milk['amount'][0]['value'],
                                                     'quantity': cheapest_milk['amount'][0]['measurement']}],[]]

    return recipe_df


def tally_ingredients(recipe_df):
    """Pass in df of week's recipes. Compiles all of the ingredients into two dictionaries (faster than growing a
    dataframe). There will be the sale and non-sale dictionary. Note: format for sale_dict is:
    {('ingredient, 'measurement'): {'store': ,  'discount': , 'quantity': }}"""
    product_collection = db_client['ingredients']

    tally_dict = defaultdict(dict)
    savings = 0

    for i in range(len(recipe_df)):

        # tally all sale items
        for ingredient in recipe_df.loc[i]['sale ingredients']:
            ingredient_obj = product_collection.find({"_id": ingredient["id"]})[0]
            if ingredient_obj["title"] not in tally_dict:
                tally_dict[ingredient_obj["title"]] = dict()
                tally_dict[ingredient_obj["title"]]["id"] = ingredient["id"]
                tally_dict[ingredient_obj["title"]]['on_sale'] = True
                tally_dict[ingredient_obj["title"]]['quantity'] = ingredient['quantity']
                tally_dict[ingredient_obj["title"]]['measurement'] = ingredient["measurement"]
                tally_dict[ingredient_obj["title"]]['grocery'] = ingredient_obj['grocery']
            else:
                tally_dict[ingredient_obj["title"]]['quantity'] += ingredient['quantity']

        # tally all non sale items
        for ingredient in recipe_df.loc[i]['non sale ingredients']:
            if ingredient["name"] not in tally_dict:
                tally_dict[ingredient["name"]] = dict()
                tally_dict[ingredient["name"]]['on_sale'] = False
                tally_dict[ingredient["name"]]['quantity'] = ingredient['quantity']
                tally_dict[ingredient["name"]]['measurement'] = ingredient["measurement"]
            else:
                tally_dict[ingredient["name"]]['quantity'] += ingredient['quantity']

    for key in tally_dict.keys():
        if tally_dict[key]['on_sale']:
            sale_data = product_collection.find_one({'_id': tally_dict[key]['id']})
            if sale_data["amount"][0]["measurement"] == tally_dict[key]["measurement"]:
                ratio = tally_dict[key]["quantity"] / sale_data["amount"][0]["value"]
                savings += ratio * sale_data["savings"]

    return tally_dict, savings
