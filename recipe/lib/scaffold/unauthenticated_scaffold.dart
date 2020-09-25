import 'package:flutter/material.dart';

class UnauthenticatedScaffold extends StatelessWidget {
  final Widget body;

  const UnauthenticatedScaffold({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
          child: body, margin: EdgeInsets.all(16.0).copyWith(bottom: 32)),
    );
  }
}
