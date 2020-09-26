import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe/utils.dart';

final supermarkets = ["Woolworths", "Coles", "IGA", "Aldi"];

class CartScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('recipesBox').listenable(keys: ['recipes']),
        builder: (context, box, widget) {
          List recipes = box.get('recipes');

          final returnIngredients = {};

          for (final recipe in recipes) {
            final ingredients = recipe['ingredients'];

            for (final ingredient in ingredients) {
              final name = ingredient['name'];
              final quantity = ingredient['quantity'];
              final measurement = ingredient['measurement'];

              if (!returnIngredients.containsKey(name)) {
                returnIngredients[name] = {
                  'quantity': quantity,
                  'measurement': measurement
                };
              }
            }
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                MyStatefulWidget(
                  ingredients: returnIngredients,
                )
              ],
            ),
          );
        });
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
    this.ingredient,
    this.label,
    this.ingredients,
  });

  final String label;
  final Map ingredient;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;
  final Map ingredients;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalize(label),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(fontSizeFactor: 0.95),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          "${ingredient['quantity']} ${ingredient['measurement']}",
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .apply(fontSizeFactor: 0.95),
                        ),
                      )
                    ]),
                    Chip(
                      label: Text(
                          supermarkets[Random().nextInt(supermarkets.length)]),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onChanged: onChanged,
      value: value,
      groupValue: true,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final Map ingredients;

  MyStatefulWidget({Key key, this.ingredients}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _isRadioSelected = false;
  final List selectedValues = [];

  @override
  Widget build(BuildContext context) {
    final tiles = ListTile.divideTiles(
      context: context,
      tiles: [
        ...widget.ingredients.keys.map((e) {
          return LabeledRadio(
            ingredients: widget.ingredients,
            label: e,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            value: selectedValues.contains(e),
            groupValue: _isRadioSelected,
            ingredient: widget.ingredients[e],
            onChanged: (Object obj) {
              setState(() {
                if (selectedValues.contains(e)) {
                  selectedValues.remove(e);
                } else {
                  selectedValues.add(e);
                }
              });
            },
          );
        }),
      ],
    ).toList();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$30 savings",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                "${selectedValues.length} bought - ${widget.ingredients.keys.length - selectedValues.length} unbought",
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
        ...tiles
      ],
    );
  }
}
