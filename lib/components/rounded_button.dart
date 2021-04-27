import 'package:flutter/material.dart';
import 'package:oyuncubul/components/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color buttonColor, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.buttonColor = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: size.width * .8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          color: buttonColor,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
