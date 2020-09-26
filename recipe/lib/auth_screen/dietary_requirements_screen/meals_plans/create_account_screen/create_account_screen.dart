import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe/main.dart';
import 'package:recipe/recipes_screen/recipes_screen.dart';
import 'package:recipe/utils.dart';

class CreateAccountScreen extends StatefulWidget {
  final String mealPlan;
  final Set<String> dietaryRequirements;

  const CreateAccountScreen({Key key, this.mealPlan, this.dietaryRequirements})
      : assert(mealPlan != null),
        assert(dietaryRequirements != null),
        super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final email = getRandomString(10) + "@example.com";
      final password = getRandomString(10);
      final name = getRandomString(10);

      final response = await ApiService.dio.post('/users/signup', data: {
        'email': email,
        'password': password,
        'name': name,
        'dietary_requirements': [widget.dietaryRequirements.toList()],
        'meal_option': widget.mealPlan
      });

      final userBox = await Hive.openBox('userBox');
      await userBox.putAll(response.data);

      final userOid = response.data['_id']['\$oid'];

      final recipesBox = await Hive.openBox('recipesBox');
      final remoteRecipes =
          await ApiService.dio.get('/recipes?user_id=$userOid');
      await recipesBox.putAll({'recipes': remoteRecipes.data['meals']});

      await Navigator.push(
          context,
          PageTransition(
              child: RecipesScreen(), type: PageTransitionType.fade));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/logo.png"),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorPallete.primaryColor),
          ),
        ],
      ),
    );
  }
}
