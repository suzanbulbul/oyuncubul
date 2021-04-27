import 'package:flutter/material.dart';
import 'package:oyuncubul/components/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final String text1;
  final String text2;
  final Function press;

  const AlreadyHaveAnAccountCheck({
    Key key,
    this.press,
    this.text1,
    this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            text2,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
