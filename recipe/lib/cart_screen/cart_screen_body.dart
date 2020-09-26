import 'package:flutter/material.dart';

class CartScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  "100 bought - 200 unbought",
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ),
          MyStatefulWidget()
        ],
      ),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(fontSizeFactor: 0.95),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 8.0),
                              child: Text("Pantry, meat",
                                  style: Theme.of(context).textTheme.subtitle2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          "100 quantity",
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .apply(fontSizeFactor: 0.95),
                        ),
                        
                      )
                    ]),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        Chip(
                          label: Text("Woolworths"),
                          padding: EdgeInsets.zero,
                        ),
                        Chip(
                          label: Text("Coles"),
                          padding: EdgeInsets.zero,
                        ),
                        Chip(
                          label: Text("IGA"),
                          padding: EdgeInsets.zero,
                        ),
                        Chip(
                          label: Text("Aldi"),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onChanged: (value) {},
      groupValue: null,
      value: null,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _isRadioSelected = false;

  @override
  Widget build(BuildContext context) {
    final tiles = ListTile.divideTiles(
      context: context,
      tiles: [
        LabeledRadio(
          label: 'This is the first label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: true,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the second label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: false,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the first label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: true,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the second label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: false,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the first label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: true,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the second label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: false,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
      ],
    ).toList();

    return Column(
      children: tiles,
    );
  }
}
