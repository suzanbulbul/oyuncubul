import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/components/rounded_input_field.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/Home/components/statusPage/components/background.dart';
import 'package:oyuncubul/screens/Home/products_screen.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _subject;
  String _detail;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "İLAN VER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            RoundedInputField(
              icon: Icon(FontAwesomeIcons.file),
              text: "Konu",
              onChanged: (val) {
                _subject = val;
              },
            ),
            RoundedInputField(
              icon: Icon(FontAwesomeIcons.envelope),
              text: "Detay",
              onChanged: (val) {
                _detail = val;
              },
            ),
            RoundedButton(
              text: "TANIMLA",
              press: () {
                statu();
              },
            ),
          ],
        ),
      ),
    );
  }

  void statu() {
    if (_detail != null && _subject != null) {
      Map<String, dynamic> data = Map();

      data["subject"] = _subject;
      data["detail"] = _detail;
      data["user_id"] = MyApp.auth.currentUser.uid;
      data["created_date"] = FieldValue.serverTimestamp();

      MyApp.firestore.collection("status").doc().set(data).then((value) {
        Toast.show("İlan tanımlanmıştır.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ProductsScreen()),
          (Route<dynamic> route) => false);
    } else {
      Toast.show("Lütfen konu ve mesaj alanlarını boş bırakmayınız!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
