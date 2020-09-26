import 'package:flutter/material.dart';
import 'package:recipe/cart_screen/cart_screen_body.dart';
import 'package:recipe/main.dart';
import 'package:recipe/widgets/scaffold/authenticated_scaffold.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticatedScaffold(
      currentIndex: 1,
      body: CartScreenBody(),
      appBar: AppBar(
        title: CartScreenTitle(),
        titleSpacing: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class CartScreenTitle extends StatefulWidget {
  @override
  _CartScreenTitleState createState() => _CartScreenTitleState();
}

class _CartScreenTitleState extends State<CartScreenTitle> {
  bool isSearching = false;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
            onPressed: () {
              setState(() {
                isSearching = false;
              });
            },
          ),
          Expanded(
              child: TextField(
            focusNode: focusNode,
            decoration: InputDecoration(hintText: "Type in something here..."),
          ))
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            splashColor: ColorPallete.primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  onPressed: null,
                ),
                Text(
                  "Search for an ingredient...",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                isSearching = true;
              });
              focusNode.requestFocus();
            },
          ),
        )
      ],
    );
  }
}
