import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe/auth_screen/dietary_requirements_screen/meals_plans/meals_plans_screen.dart';
import 'package:recipe/widgets/recipes_filter.dart';
import 'package:recipe/widgets/scaffold/unauthenticated_scaffold.dart';

List<String> options = [
  'Vegan',
  'Lactose intolerant',
  'Egg intolerant',
  'Peanut intolerant',
  'Gluten free',
];

class DietaryRequirementsScreen extends StatefulWidget {
  @override
  _DietaryRequirementsScreenState createState() =>
      _DietaryRequirementsScreenState();
}

class _DietaryRequirementsScreenState extends State<DietaryRequirementsScreen> {
  final selectedItems = Set<String>();

  @override
  Widget build(BuildContext context) {
    return UnauthenticatedScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My dietary\nrequirements are",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.left,
          ),
          Wrap(
            children: dietaryRequirements
                .map((e) => Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: selectedItems.contains(e),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedItems.add(e);
                            } else {
                              selectedItems.remove(e);
                            }
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealsPlansScreen(
                        dietaryRequirements: selectedItems,
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
