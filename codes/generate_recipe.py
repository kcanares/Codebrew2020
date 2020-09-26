import pymongo
from pymongo import MongoClient


def generate_recipe(user_id):
    client = MongoClient("mongodb://165.22.254.55:27017/")
    db = client['codebrew2020']

    product_collection = db['ingredients']
    recipe_collection = db['recipes']
    user_collection = db['users']

    products = product_collection.find({})
    recipes = recipe_collection.find({})
    user = user_collection.find_one({'_id': user_id})

    # keep a count of how many discounted products are in each recipe as well as what are the discounts
    recipe_info = dict()
    # keep track of the top 5 recipes {1: {'id', 'discount_ratio'}, 2: {'id', 'discount_ratio'}...}
    top_10_recipe = dict()

    for recipe in recipes:

        # initialise one recipe
        recipe_info[recipe['_id']] = recipe
        '''recipe_info['_id']['nutrition'] = recipe['nutrition']
        recipe_info['_id']['ingredients'] = recipe['ingredients']
        recipe_info['_id']['steps'] = recipe['steps']
        recipe_info['_id']['name'] = recipe['name']
        recipe_info['_id']['image_url'] = recipe['image_url']
        recipe_info['_id']['prep_time'] = recipe['prep_time']
        recipe_info['_id']['cooking_time'] = recipe['cooking_time']'''
        recipe_info[recipe['_id']]['ratio'] = 0
        recipe_info[recipe['_id']]['discounts'] = dict()

        for ingredient in recipe['ingredients']:
            # check allergy
            if ingredient['name'] in user['dietary_req']:
                recipe_info.pop(recipe['_id'])
                break

            # check discount
            for product in products:
                if ingredient['name'] in product['title']:
                    recipe_info[recipe['_id']]['discounts'][ingredient['name']] = product
                    recipe_info[recipe['_id']]['ratio'] = len(recipe_info[recipe['_id']]['discounts']) / \
                                                          recipe_info[recipe['_id']]['ingredients']

        # update top 10
        top_10_recipe = update_top_10(top_10_recipe, recipe_info[recipe['_id']])

        # return top 10
        top_10_list = []
        highest = 10
        for i in range(1, highest+1):
            top_10_list.append(recipe_info[top_10_list[i]['_id']])

        return top_10_list


def update_top_10(top_10, one_recipe):
    if len(top_10) == 0:
        top_10[1]['_id'] = one_recipe['_id']
        top_10[1]['ratio'] = one_recipe['ratio']
    count = 10
    switch_pos = 0
    if len(top_10) < count:
        count = len(top_10)
    for i in range(count, 0, -1):
        if top_10[i]['ratio'] < one_recipe['ratio']:
            switch_pos = i
        else:
            break

    if switch_pos:
        for j in range(count, switch_pos-1, -1):
            if j == 10:
                continue
            else:
                top_10[j+1]['_id'] = top_10[j]['_id']
                top_10[j+1]['ratio'] = top_10[j]['ratio']

        top_10[switch_pos]['_id'] = one_recipe['_id']
        top_10[switch_pos]['ratio'] = one_recipe['ratio']

    if count < 10 and switch_pos == 0:
        top_10[count+1]['id'] = one_recipe['_id']
        top_10[count+1]['ratio'] = one_recipe['ratio']

    return top_10
