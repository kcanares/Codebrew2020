import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe/auth_screen/auth_screen.dart';
import 'package:recipe/splash_screen/splash_screen.dart';
import 'package:recipe/widgets/scaffold/authenticated_scaffold.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticatedScaffold(
      currentIndex: 2,
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("Log Out"),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                await Hive.deleteFromDisk();
                await Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: SplashScreen(), type: PageTransitionType.fade),
                    (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}
