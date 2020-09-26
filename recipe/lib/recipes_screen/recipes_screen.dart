import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:recipe/main.dart';
import 'package:recipe/recipes_screen/weekly_recipes_screen/weekly_recipes_screen.dart';
import 'package:recipe/widgets/recipes_filter.dart';
import 'package:recipe/widgets/scaffold/authenticated_scaffold.dart';

const CURVE_HEIGHT = 300.0;

class RecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticatedScaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.lighPrimaryColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      currentIndex: 0,
      body: ListView(
        children: [
          Stack(
            children: [
              CurvedShape(),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Today's Recipes",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: ColorPallete.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Wrap(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Recipes Options",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorPallete
                                                                .primaryColor)),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child: StoresFilter(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child: MealsPlansFilter(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child:
                                                  DietaryRequirementsFilter(),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Save"),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.view_list),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeeklyRecipesScreen(),
                                    ));
                              },
                              splashColor: Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Carousel()
                ],
              )
            ],
          ),
          NutritionChart()
        ],
      ),
    );
  }
}

class NutritionChart extends StatelessWidget {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  colorList: colorMap.values.toList(),
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 10,
                  centerText: "WEEKLY\nNUTRITION",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    showLegends: false,
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValues: false,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...dataMap.keys.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorMap[e])),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .apply(color: Color(0xFF0B5B53)),
                              ),
                            ),
                            Text(
                              dataMap[e].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .apply(color: Colors.black),
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  color: ColorPallete
                                                      .primaryColor),
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
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final items = <String>[];
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 220.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller:
                PageController(viewportFraction: 0.4, initialPage: _page),
            itemCount: 3,
            onPageChanged: (page) {
              setState(() {
                _page = page;
              });
            },
            itemBuilder: (BuildContext context, int itemIndex) {
              final isSelected = itemIndex == _page;

              return AnimatedContainer(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: isSelected ? 8.0 : 20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Material(
                        color: ColorPallete.primaryColor,
                        elevation: 5,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: Container(),
                      ),
                    ),
                    AnimatedOpacity(
                        duration: Duration(milliseconds: 100),
                        opacity: isSelected ? 1 : 0,
                        child: Column(
                          children: [Text("Something"), Text("500kj")],
                        ))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class CurvedShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHT,
      child: CustomPaint(
        painter: _MyPainter(),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = ColorPallete.lighPrimaryColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
