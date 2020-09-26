import 'package:flutter/material.dart';
import 'package:recipe/main.dart';
import 'package:recipe/single_recipe_screen/recipes_ingredients.dart';
import 'package:recipe/single_recipe_screen/recipes_nutritions_tab_view.dart';
import 'package:recipe/single_recipe_screen/recipes_tab_view.dart';

const _imageHeight = 220.0;

enum SingingCharacter { lafayette, jefferson }

// ...

SingingCharacter _character = SingingCharacter.lafayette;

class SingleRecipeScreen extends StatelessWidget {
  final Map recipes;

  const SingleRecipeScreen({Key key, this.recipes})
      : assert(recipes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              top: _imageHeight,
              child: Material(
                elevation: 8,
                child: Column(
                  children: [
                    Container(
                      color: ColorPallete.lighPrimaryColor,
                      child: TabBar(
                        indicatorColor: ColorPallete.primaryColor,
                        tabs: [
                          Tab(text: "Ingredients"),
                          Tab(text: "Recipes"),
                          Tab(text: "Nutrition Facts"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          RecipesIngredients(recipes: recipes),
                          RecipesTabView(
                            recipes: recipes,
                          ),
                          RecipesNutritionTabView(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              height: _imageHeight,
              width: MediaQuery.of(context).size.width,
              child: Container(
                width: double.infinity,
                height: _imageHeight,
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recipes['image_url']),
                    fit: BoxFit.cover,
                  ),
                )),
              ),
            ),
            Positioned(
                top: 0,
                width: MediaQuery.of(context).size.width,
                height: _imageHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipes['name'],
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: ColorPallete.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
                top: 195,
                right: 10,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: Material(
                        elevation: 30,
                        color: ColorPallete.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(100000)),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
