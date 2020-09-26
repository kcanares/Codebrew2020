import 'package:flutter/material.dart';

class RecipesTabView extends StatelessWidget {
  final Map recipes;

  const RecipesTabView({Key key, this.recipes})
      : assert(recipes != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (final step in recipes['steps']) {
      children.add(Card(
          elevation: 4,
          child: Padding(padding: EdgeInsets.all(18.0), child: Text(step))));
    }
    return MediaQuery.removePadding(
        removeTop: true, context: context, child: ListView(children: children));
  }
}
