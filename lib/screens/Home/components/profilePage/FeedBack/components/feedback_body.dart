import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/components/rounded_input_field.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/Home/components/profilePage/FeedBack/components/background.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _subject;
  String _message;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GERİ BİLDİRİM",
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
              text: "Mesaj",
              onChanged: (val) {
                _message = val;
              },
            ),
            RoundedButton(
              text: "BİLDİR",
              press: () {
                feedback();
              },
            ),
          ],
        ),
      ),
    );
  }

  void feedback() {
    if (_message != null && _subject != null) {
      Map<String, dynamic> data = Map();

      data["subject"] = _subject;
      data["message"] = _message;
      data["user_id"] = MyApp.auth.currentUser.uid;
      data["created_date"] = FieldValue.serverTimestamp();

      MyApp.firestore.collection("feedbacks").doc().set(data).then((value) {
        Toast.show("Geri bildirimde bulunduğunuz için teşekkürler!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
      Navigator.of(context).pop();
    } else {
      Toast.show("Lütfen konu ve mesaj alanlarını boş bırakmayınız!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
