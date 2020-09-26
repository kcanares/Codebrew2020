import 'package:flutter/material.dart';
import 'package:recipe/main.dart';
import 'package:recipe/recipes_screen/weekly_recipes_screen/weekly_recipes_screen.dart';
import 'package:recipe/single_recipe_screen/recipes_nutritions_tab_view.dart';
import 'package:recipe/single_recipe_screen/recipes_tab_view.dart';

const _imageHeight = 220.0;

enum SingingCharacter { lafayette, jefferson }

// ...

SingingCharacter _character = SingingCharacter.lafayette;

class SingleRecipeScreen extends StatelessWidget {
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
                          Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(12.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Material(
                                      color: Color(0xFFF0F0F0),
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Servings",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            Text(
                                              "4 (300kj)",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                            RadioListTile<SingingCharacter>(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Something"),
                                                  Text("Meat",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption)
                                                ],
                                              ),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged:
                                                  (SingingCharacter value) {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          RecipesTabView(),
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
                child: FittedBox(
                  child: Image.network(
                    placeholderImageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
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
                          "Fried Rice",
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
