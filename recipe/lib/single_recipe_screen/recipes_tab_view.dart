import 'package:flutter/material.dart';

const steps = [
  "Heat oven to 190C/170C fan/gas 5. Put the pumpkin, sage, maple syrup and shallots in a roasting tin and give it a good mix with your hands, making sure you coat everything in the syrup. Add half the butter and sprinkle with salt, then roast for 45 mins or until the pumpkin is tender.",
  "While the vegetables are roasting, heat a frying pan, add a splash of oil and the remaining butter. When foaming, add the venison and sear as quickly as you can. Remove from the heat and set aside. Once the vegetables are soft, lay the loin on top and return the tin to the oven to cook for another 15-20 mins.",
  "While the venison is roasting, put the Sichuan peppercorns, salt and rosemary into a pestle and mortar and grind to a coarse seasoning. When the venison is cooked, remove from the oven and rest for 10 mins. While it\u2019s resting, brush with the glaze from the pan and sprinkle over a generous pinch of the seasoning. Serve the carved venison with the pumpkin and shallots."
];

class RecipesTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: steps
          .map((step) => Card(
              elevation: 4,
              child: Padding(padding: EdgeInsets.all(18.0), child: Text(step))))
          .toList(),
    );
  }
}
