import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/components/rounded_input_field.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/Login/components/background.dart';
import 'package:toast/toast.dart';

import 'file:///C:/Users/Suzan%20Nur/Desktop/oyuncubul/lib/screens/Home/products_screen.dart';

//ignore: must_be_immutable
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
                "KAYIT OL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RoundedInputField(
                text: "Kullanıcı adı",
                onChanged: (val) {
                  _username = val;
                },
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
              ),
              RoundedInputField(
                text: "Yaş",
                onChanged: (val) {
                  _age = val;
                },
                icon: Icon(
                  FontAwesomeIcons.calendar,
                  color: kPrimaryColor,
                ),
              ),
              RoundedInputField(
                text: "Kilo",
                onChanged: (val) {
                  _weight = val;
                },
                icon: Icon(
                  FontAwesomeIcons.weight,
                  color: kPrimaryColor,
                ),
              ),
              RoundedInputField(
                text: "Boy",
                onChanged: (val) {
                  _length = val;
                },
                icon: Icon(
                  FontAwesomeIcons.ruler,
                  color: kPrimaryColor,
                ),
              ),
              RoundedButton(
                text: "KAYIT OL",
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
            MaterialPageRoute(builder: (context) => ProductsScreen()),
            (Route<dynamic> route) => false);
      } else {
        Toast.show("Lütfen ad ve soyad alanlarını boş bırakmayınız!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show(
          "Lütfen yaş, kilo ve uzunluk alanlarına sayı giriniz!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    if (!login) {
      await MyApp.auth.signInAnonymously();
    }
  }
}
