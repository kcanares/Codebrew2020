import 'package:flutter/material.dart';
import 'package:recipe/auth_screen/dietary_requirements_screen/dietary_requirements_screen.dart';
import 'package:recipe/widgets/scaffold/unauthenticated_scaffold.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnauthenticatedScaffold(
      body: Column(
        children: [
          Image.asset('assets/images/logo.png'),
          RaisedButton(
            child: Text("Getting Started"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietaryRequirementsScreen(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
