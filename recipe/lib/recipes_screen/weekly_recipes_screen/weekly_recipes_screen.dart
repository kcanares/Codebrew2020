import 'package:flutter/material.dart';
import 'package:recipe/main.dart';
import 'package:recipe/single_recipe_screen/single_recipe_screen.dart';

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
      body: ListView(
        children: [
          DayRecipe(),
          DayRecipe(),
          DayRecipe(),
          DayRecipe(),
          DayRecipe(),
          DayRecipe(),
          DayRecipe(),
        ],
      ),
    );
  }
}

class DayRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 12.0, bottom: 12.0, top: 24.0),
          child: Text(
            "Monday",
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
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int itemIndex) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleRecipeScreen(),
                          ));
                    },
                    child: Container(
                      width: 280,
                      padding: EdgeInsets.only(right: 12, left: 12),
                      child: Material(
                        elevation: 8,
                        child: FittedBox(
                          child: Image.network(
                            placeholderImageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                                "Fried Rice",
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
              );
            },
          ),
        )
      ],
    );
  }
}
