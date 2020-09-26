import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe/auth_screen/auth_screen.dart';
import 'package:recipe/recipes_screen/recipes_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final box = await Hive.openBox('userBox');

      bool isLoggedIn = box.get('_id') != null;

      if (isLoggedIn) {
        await Navigator.pushReplacement(
            context,
            PageTransition(
                child: RecipesScreen(), type: PageTransitionType.fade));
      } else {
        await Navigator.pushReplacement(context,
            PageTransition(child: AuthScreen(), type: PageTransitionType.fade));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset("assets/images/logo.png")],
      ),
    );
  }
}
