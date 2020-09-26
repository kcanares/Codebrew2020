import 'package:flutter/material.dart';
import 'package:recipe/cart_screen/cart_screen.dart';
import 'package:recipe/recipes_screen/recipes_screen.dart';

class AuthenticatedScaffold extends StatelessWidget {
  final Widget body;
  final AppBar appBar;
  final int currentIndex;

  const AuthenticatedScaffold(
      {Key key, this.body, this.appBar, this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), title: Text("Recipes")),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Cart")),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), title: Text("More"))
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesScreen(),
                ));
          } else if (index == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
          }
        },
      ),
      body: body,
    );
  }
}
