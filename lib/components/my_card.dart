import 'package:flutter/material.dart';

import 'constants.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function press;
  final Widget icon;

  const MyCard({
    Key key,
    this.title,
    this.subtitle,
    this.press,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        LayoutBuilder(
          builder: (context, constraint) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: constraint.maxWidth - 10,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 17),
                        blurRadius: 23,
                        spreadRadius: -13,
                        color: kShadowColor,
                      )
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: press,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(29),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 23,
                                  spreadRadius: -13,
                                  color: kShadowColor,
                                )
                              ]),
                          child: icon,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                title,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(subtitle)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
