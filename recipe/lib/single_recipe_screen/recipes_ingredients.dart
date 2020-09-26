import 'package:flutter/material.dart';
import 'package:recipe/utils.dart';

class RecipesIngredients extends StatelessWidget {
  final Map recipes;

  const RecipesIngredients({Key key, this.recipes})
      : assert(recipes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Servings",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${recipes['servings']} (${recipes['nutrition']['kcal']}kj)",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              IngredientsList(
                ingredients: recipes['ingredients'],
              )
            ],
          ),
        ));
  }
}

class IngredientsList extends StatelessWidget {
  final List ingredients;

  const IngredientsList({Key key, this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (final ingredient in ingredients) {
      children.add(ListTile(
          title: Text(capitalize(ingredient['name'])),
          trailing: Text(
            "${ingredient['quantity']} ${ingredient['measurement']}",
            style: Theme.of(context).textTheme.subtitle2,
          )));
    }

    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          children:
              ListTile.divideTiles(tiles: children, context: context).toList(),
        ),
      ),
    );
  }
}
