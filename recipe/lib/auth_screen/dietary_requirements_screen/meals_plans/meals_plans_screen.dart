import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe/auth_screen/dietary_requirements_screen/meals_plans/create_account_screen/create_account_screen.dart';
import 'package:recipe/recipes_screen/recipes_screen.dart';
import 'package:recipe/widgets/recipes_filter.dart';
import 'package:recipe/widgets/scaffold/unauthenticated_scaffold.dart';

class MealsPlansScreen extends StatefulWidget {
  final Set<String> dietaryRequirements;

  const MealsPlansScreen({Key key, this.dietaryRequirements})
      : assert(dietaryRequirements != null),
        super(key: key);

  @override
  _MealsPlansScreenState createState() => _MealsPlansScreenState();
}

class _MealsPlansScreenState extends State<MealsPlansScreen> {
  String selectedItem = mealsPlans.first;

  @override
  Widget build(BuildContext context) {
    return UnauthenticatedScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("My meals preferences",
              style: Theme.of(context).textTheme.headline4),
          Wrap(
            children: [
              ...mealsPlans
                  .map((e) => Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(e),
                          onSelected: (isSelected) {
                            setState(() {
                              selectedItem = e;
                            });
                          },
                          selected: selectedItem == e,
                        ),
                      ))
                  .toList()
            ],
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: CreateAccountScreen(
                          mealPlan: selectedItem,
                          dietaryRequirements: widget.dietaryRequirements,
                        ),
                        type: PageTransitionType.fade),
                    (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
