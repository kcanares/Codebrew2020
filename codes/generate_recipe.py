import pymongo
from pymongo import MongoClient
import pandas as pd
from pandas import DataFrame
import numpy as np
from bson.objectid import ObjectId
from collections import defaultdict

DAYS_IN_A_WEEK = 7

def generate_recipe(user_id):
    """"matches recipes to ingredients. sorts them according to match ratio"""

    # connect to client and get collections
    client = MongoClient("mongodb://165.22.254.55:27017/")
    db = client['codebrew2020']

    product_collection = db['ingredients']
    recipe_collection = db['recipes']
    user_collection = db['user']

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
            # TODO: check allergy
            # if ingredient['name'] in user['dietary_req']:
            #     recipe_info.pop(recipe['_id'])
            #     break

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
                                                                      "quantity": ingredient['name'],
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
    # for debugging
    recipe_df.to_csv("match.csv")

    # meal_no = calculate_user_meal_no(user)["meals"]
    meal_no = 14
    return recipe_df.iloc[:meal_no][:].reset_index(drop=True)


def calculate_user_meal_no(user):
    if user['dietary_requirements'] == "Everything":
        return {"breakfast": 1, "meals": 2 * DAYS_IN_A_WEEK}


def tally_ingredients(recipe_df):
    """Pass in df of week's recipes. Compiles all of the ingredients into two dictionaries (faster than growing a
    dataframe). There will be the sale and non-sale dictionary. Note: format for sale_dict is:
    {('ingredient, 'measurement'): {'store': ,  'discount': , 'quantity': }}"""

    non_sale_dict = defaultdict(dict)
    savings = 0
    print(recipe_df.columns)
    for i in range(len(recipe_df)):
        for ingredient in recipe_df.loc[i]['non sale ingredients']:
            non_sale_dict[ingredient["name"], ingredient["measurement"]] += ingredient['quantity']

    print(non_sale_dict)

"""
def find_breakfast():
"""

recipe_df = generate_recipe('5f6e7fdf20993e3adbef5535')

recipe_df.to_csv("week recipes.csv")
tally_ingredients(recipe_df)

print(tally_ingredients(recipe_df))
