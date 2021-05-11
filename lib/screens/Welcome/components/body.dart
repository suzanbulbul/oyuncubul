import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/screens/Login/sign_in_screen.dart';
import 'package:oyuncubul/screens/SignUp/sign_up_screen.dart';
import 'package:oyuncubul/screens/Welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "HOŞ GELDİN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            SvgPicture.asset(
              "assets/icons/welcome.svg",
              height: size.height * .45,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            RoundedButton(
              text: "GİRİŞ YAP",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SigninScreen();
                }));
              },
            ),
            RoundedButton(
              text: "KAYIT OL",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignupScreen();
                }));
              },
              textColor: Colors.black,
              buttonColor: kPrimaryLightColor,
            ),
          ],
        ),
      ),
    );
  }
}
