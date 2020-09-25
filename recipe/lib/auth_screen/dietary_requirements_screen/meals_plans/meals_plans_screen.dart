import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe/scaffold/unauthenticated_scaffold.dart';

final _choices = ['Everything', 'No breakfast', 'No lunch', 'No dinner'];

class MealsPlansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnauthenticatedScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("My meals preferences",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Color(0xFFf0efeb))),
          Wrap(
            children: [
              ..._choices
                  .map((e) => Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: ActionChip(
                          label: Text(e),
                          onPressed: () {
                            
                          },
                        ),
                      ))
                  .toList()
            ],
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Next"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
