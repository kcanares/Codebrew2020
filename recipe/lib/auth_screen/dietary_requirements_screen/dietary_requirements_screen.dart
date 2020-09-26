import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe/auth_screen/dietary_requirements_screen/meals_plans/meals_plans_screen.dart';
import 'package:recipe/widgets/scaffold/unauthenticated_scaffold.dart';

List<String> options = [
  'Vegan',
  'Lactose intolerant',
  'Egg intolerant',
  'Peanut intolerant',
  'Gluten free',
];

class DietaryRequirementsScreen extends StatelessWidget {
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
          ChipsChoice<String>.multiple(
            isWrapped: true,
            value: [options.first],
            options: ChipsChoiceOption.listFrom<String, String>(
              source: options,
              value: (i, v) => v,
              label: (i, v) => v,
            ),
            onChanged: (val) {},
            padding: EdgeInsets.zero,
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealsPlansScreen(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
