import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_fit/components/constants.dart';
import 'package:my_fit/components/rounded_button.dart';
import 'package:my_fit/components/rounded_input_field.dart';
import 'package:my_fit/main.dart';
import 'package:my_fit/screens/Home/home_screen.dart';
import 'package:my_fit/screens/Login/components/background.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  bool login;

  Body({bool login}) {
    this.login = login;
  }

  @override
  State<StatefulWidget> createState() {
    return BodyState(
      login: login,
    );
  }
}

class BodyState extends State<Body> {
  String _username;
  String _age;
  String _weight;
  String _length;
  bool login;

  BodyState({bool login}) {
    this.login = login;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "REGISTER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RoundedInputField(
                text: "Username",
                onChanged: (val) {
                  _username = val;
                },
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
              ),
              RoundedInputField(
                text: "Age",
                onChanged: (val) {
                  _age = val;
                },
                icon: Icon(
                  FontAwesomeIcons.calendar,
                  color: kPrimaryColor,
                ),
              ),
              RoundedInputField(
                text: "Weight",
                onChanged: (val) {
                  _weight = val;
                },
                icon: Icon(
                  FontAwesomeIcons.weight,
                  color: kPrimaryColor,
                ),
              ),
              RoundedInputField(
                text: "Length",
                onChanged: (val) {
                  _length = val;
                },
                icon: Icon(
                  FontAwesomeIcons.ruler,
                  color: kPrimaryColor,
                ),
              ),
              RoundedButton(
                text: "REGISTER",
                press: () {
                  register(_username, _age, _weight, _length);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register(
      String username, String age, String weight, String length) async {
    int _age;
    double _weight;
    double _length;

    try {
      _age = int.parse(age);
      _weight = double.parse(weight);
      _length = double.parse(length);

      if (username != null) {
        Map<String, dynamic> data = Map();

        data["user_id"] = MyApp.auth.currentUser.uid;
        data["username"] = username;
        data["age"] = _age;
        data["weight"] = _weight;
        data["length"] = _length;
        data["created_date"] = FieldValue.serverTimestamp();

        MyApp.firestore.collection("users").doc().set(data).then((value) {});
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      } else {
        Toast.show(
            "Please do not leave the name and surname fields blank!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show(
          "Please enter numbers in the age, weight and length fields!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    if (!login) {
      await MyApp.auth.signInAnonymously();
    }
  }
}
