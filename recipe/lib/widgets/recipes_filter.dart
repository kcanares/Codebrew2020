import 'package:flutter/material.dart';

const _stores = ["Coles", "Woolies", "Aldi", "IGA"];

const _mealsPlans = ['Everything', 'No breakfast', 'No lunch', 'No dinner'];

const _dietaryRequirements = [
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
            ..._stores.map((e) => Padding(
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
            ..._mealsPlans.map((e) => Padding(
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
            ..._dietaryRequirements.map((e) => Padding(
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
