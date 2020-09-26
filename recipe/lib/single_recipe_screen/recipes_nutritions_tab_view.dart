import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:recipe/main.dart';
import 'package:recipe/recipes_screen/recipes_screen.dart';

class RecipesNutritionTabView extends StatelessWidget {
  final Map recipes;

  const RecipesNutritionTabView({Key key, this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "carbs": 0,
      "fat": 0,
      "saturates": 0,
      "sugars": 0,
      "fibre": 0
    };
    final nutrition = recipes['nutrition'];

    for (final key in nutrition.keys) {
      if (dataMap.containsKey(key)) {
        dataMap[key] += nutrition[key];
      }
    }

    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: [
          Column(
              children: dataMap.keys.map((key) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 12.0),
              child: Card(
                elevation: 3,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                key,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .apply(color: ColorPallete.primaryColor),
                              ),
                            ),
                            Text(
                              "Recommended: ${(nutritionWeekly[key] / 7).toInt()}/d",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .apply(color: Color(0xFF6E7781)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: PieChart(
                          chartType: ChartType.ring,
                          ringStrokeWidth: 6,
                          colorList: [Color(0xFF05C985), Color(0xFF3E4E6C)],
                          centerText:
                              "${((dataMap[key] / (nutritionWeekly[key] / 7)) * 100).toInt()}%",
                          dataMap: {
                            key: (dataMap[key] / nutritionWeekly[key]) * 100,
                            "Other": 100 -
                                ((dataMap[key] / nutritionWeekly[key]) * 100)
                          },
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            showLegends: false,
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValues: false,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
