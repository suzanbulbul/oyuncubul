import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/components/rounded_input_field.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/Login/components/background.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  String username;
  String surname;
  String age;
  String weight;
  String dataId;
  String length;
  String _username;
  String _age;
  String _weight;
  String _length;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<QuerySnapshot>(
            future: MyApp.firestore.collection("users").get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                QuerySnapshot qs = snapshot.data;
                Map<String, dynamic> data;
                qs.docs.forEach((element) {
                  if (element.data()['user_id'] == MyApp.auth.currentUser.uid) {
                    data = element.data();
                    dataId = element.id;
                  }
                });

                _username = data["username"];
                _age = data["age"].toString();
                _weight = data["weight"].toString();
                _length = data["length"].toString();
                username = _username;
                age = _age;
                weight = _weight;
                length = _length;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RoundedInputField(
                      text: _username,
                      onChanged: (val) {
                        _username = val;
                      },
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                    ),
                    RoundedInputField(
                      text: _age,
                      onChanged: (val) {
                        _age = val;
                      },
                      icon: Icon(
                        FontAwesomeIcons.calendar,
                        color: kPrimaryColor,
                      ),
                    ),
                    RoundedInputField(
                      text: _weight,
                      onChanged: (val) {
                        _weight = val;
                      },
                      icon: Icon(
                        FontAwesomeIcons.weight,
                        color: kPrimaryColor,
                      ),
                    ),
                    RoundedInputField(
                      text: _length,
                      onChanged: (val) {
                        _length = val;
                      },
                      icon: Icon(
                        FontAwesomeIcons.ruler,
                        color: kPrimaryColor,
                      ),
                    ),
                    RoundedButton(
                      text: "EDIT",
                      press: () {
                        edit(_username, _age, _weight, _length);
                      },
                    ),
                  ],
                );
              }

              return Text("");
            },
          ),
        ),
      ),
    );
  }

  void edit(String namee, String agee, String weightt, String lengthh) async {
    try {
      Map<String, dynamic> data = Map();

      data["username"] = namee == null ? username : namee;
      data["age"] = agee == null ? int.parse(age) : int.parse(agee);
      data["weight"] =
          weightt == null ? double.parse(weight) : double.parse(weightt);
      data["length"] =
          lengthh == null ? double.parse(length) : double.parse(lengthh);
      data["update_time"] = FieldValue.serverTimestamp();
      // password validation regex

      MyApp.firestore
          .collection("users")
          .doc(dataId)
          .update(data)
          .then((value) {
        Toast.show("Profile Edited!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
      Navigator.of(context).pop();
    } catch (e) {
      Toast.show(
          "Please enter numbers in the age, weight and length fields!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
