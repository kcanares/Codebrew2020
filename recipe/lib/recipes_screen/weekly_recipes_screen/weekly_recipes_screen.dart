import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:recipe/main.dart';
import 'package:recipe/single_recipe_screen/single_recipe_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

const placeholderImageUrl =
    "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/blondies-b6a1b90.jpg?quality=90&resize=440,400";

class WeeklyRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weekly Recipes"),
        actions: [
          IconButton(icon: Icon(Icons.sync), onPressed: () {}),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box('recipesBox').listenable(keys: ['recipes']),
          builder: (context, box, widget) {
            List recipes = box.get('recipes');

            // final todayRecipes = recipes.where((recipe) {
            //   return recipe['day'] == DateFormat('EEEE').format(DateTime.now());
            // }).toList();
            final children = <Widget>[];

            for (int i = 0; i < 7; i++) {
              DateTime date = DateTime.now().add(Duration(days: i));
              final todayRecipes = recipes.where((recipe) {
                return recipe['day'] == DateFormat('EEEE').format(date);
              }).toList();

              children.add(DayRecipe(
                recipes: todayRecipes,
                date: date,
              ));
            }

            return ListView(children: children);
          }),
    );
  }
}

class DayRecipe extends StatelessWidget {
  final List recipes;
  final DateTime date;

  const DayRecipe({Key key, this.recipes, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 12.0, bottom: 12.0, top: 24.0),
          child: Text(
            DateFormat('EEEE').format(date),
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: Colors.black),
          ),
        ),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 140.0,
          child: ListView.builder(
            // store this controller in a State to save the carousel scroll position
            itemCount: recipes.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int itemIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleRecipeScreen(
                          recipes: recipes[itemIndex],
                        ),
                      ));
                },
                child: Stack(
                  children: [
                    Container(
                      width: 280,
                      padding: EdgeInsets.only(right: 12, left: 12),
                      child: Material(
                        elevation: 8,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                          image: NetworkImage(recipes[itemIndex]['image_url']),
                          fit: BoxFit.cover,
                        ))),
                      ),
                    ),
                    Positioned.fill(
                        right: 12,
                        left: 12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Material(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  recipes[itemIndex]['name'],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: ColorPallete.primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
