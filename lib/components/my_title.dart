import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String title;

  const MyTitle({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
