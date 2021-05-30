import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/components/rounded_password_field.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/SignUp/components/background.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  String _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "YENİ ŞİFRE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              RoundedPasswordField(
                onChanged: (val) {
                  _password = val;
                },
              ),
              RoundedButton(
                text: "ŞİFRE DEĞİŞTİR",
                press: () {
                  changePassword(_password);
                },
                textColor: Colors.white,
                buttonColor: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changePassword(String password) {
    if (_password != null) {
      MyApp.auth.currentUser.updatePassword(password).then((value) {
        Toast.show("Şifre değişti!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
      Navigator.of(context).pop();
    } else {
      Toast.show("Parola alanı boş olamaz!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
