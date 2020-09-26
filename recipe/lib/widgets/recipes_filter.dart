import 'package:flutter/material.dart';

const stores = ["Coles", "Woolies", "Aldi", "IGA"];

const mealsPlans = ['Everything', 'No breakfast', 'No lunch', 'No dinner'];

const dietaryRequirements = [
  'Vegan',
  'Lactose intolerant',
  'Egg intolerant',
  'Peanut intolerant',
  'Gluten free',
];

class StoresFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Stores",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        Wrap(
          children: [
            ...stores.map((e) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(e),
                    selected: false,
                    onSelected: (isSelected) {},
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

class MealsPlansFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meals Plans",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        Wrap(
          children: [
            ...mealsPlans.map((e) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(e),
                    selected: false,
                    onSelected: (isSelected) {},
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

class DietaryRequirementsFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meals Plans",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        Wrap(
          children: [
            ...dietaryRequirements.map((e) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(e),
                    selected: false,
                    onSelected: (isSelected) {},
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
