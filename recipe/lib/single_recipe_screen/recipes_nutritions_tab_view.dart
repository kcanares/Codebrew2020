import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:recipe/main.dart';

class RecipesNutritionTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Carbs": 14,
      "Fat": 32,
      "Saturates": 10,
      "Sugars": 11,
      "Fibre": 3
    };
    Map<String, Color> colorMap = {
      "Carbs": Color(0xFF0B5B53),
      "Fat": Color(0xFFFFAB4F),
      "Saturates": Color(0xFFEE423D),
      "Sugars": Color(0xFF1F8EFA),
      "Fibre": Color(0xFF843FA0),
    };
    return ListView(
      children: [
        Column(
            children: dataMap.keys
                .map((key) => Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        key,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .apply(
                                                color:
                                                    ColorPallete.primaryColor),
                                      ),
                                    ),
                                    Text(
                                      "Recommended: 160gm/w",
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
                                  colorList: [
                                    Color(0xFF05C985),
                                    Color(0xFF3E4E6C)
                                  ],
                                  centerText: "130%",
                                  dataMap: {key: dataMap[key], "Other": 100},
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
                    ))
                .toList()),
      ],
    );
  }
}
