import pymongo
from pymongo import MongoClient
from pandas import DataFrame
import numpy as np

def generate_recipe(user_id):
    client = MongoClient("mongodb://165.22.254.55:27017/")
    db = client['codebrew2020']

    product_collection = db['ingredients']
    recipe_collection = db['recipes']
    user_collection = db['user']

    products = product_collection.find({})
    recipes = recipe_collection.find({})
    user = user_collection.find_one({'_id': user_id})

    recipe_lst = list(recipes)
    recipe_df = DataFrame(recipe_lst)
    recipe_df["ratio"] = np.nan

    # create a column of empty lists
    recipe_df["sale ingredients"] = np.empty((len(recipe_df), 0)).tolist()
    product_lst =list(products)

    for i in range(len(recipe_df)):
        for ingredient in recipe_df.iloc[i]['ingredients']:
            # TODO: check allergy
            # if ingredient['name'] in user['dietary_req']:
            #     recipe_info.pop(recipe['_id'])
            #     break

            # check discount
            for product in product_lst:
                for word in ingredient['name'].split():
                    if word in product['title']:
                        recipe_df.iloc[i]["sale ingredients"].append(product['_id'])
        ratio = float(len(recipe_df.loc[i]["sale ingredients"]) / len(recipe_df.loc[i]['ingredients']))
        recipe_df.loc[i]['ratio'] = ratio

    recipe_df.sort_values(by=['ratio'])
    print(recipe_df.iloc[:]['ratio'])
    # # return top 10
    # top_10_list = []
    # highest = 10
    # for i in range(0, highest):
    #     top_10_list.append(recipe_info[top_10_recipe[i]['_id']])
    #
    # return top_10_list


print(generate_recipe('5f6e7fdf20993e3adbef5535'))