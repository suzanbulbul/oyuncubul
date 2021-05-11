import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oyuncubul/components/already_have_an_account_check.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/components/rounded_button.dart';
import 'package:oyuncubul/components/rounded_input_field.dart';
import 'package:oyuncubul/components/rounded_password_field.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/Login/components/background.dart';
import 'package:oyuncubul/screens/SignUp/register_screen.dart';
import 'package:oyuncubul/screens/SignUp/sign_up_screen.dart';
import 'package:toast/toast.dart';

import 'file:///C:/Users/Suzan%20Nur/Desktop/oyuncubul/lib/screens/Home/products_screen.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      // FlutterFire'ı başlatın:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Upss! Bir şeyler yanlış gitti");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Background(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OTURUM AÇ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * .35,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    RoundedInputField(
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      text: "Kullancı maili",
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    RoundedPasswordField(
                      onChanged: (val) {
                        _password = val;
                      },
                    ),
                    AlreadyHaveAnAccountCheck(
                      text1: "Şifreni mi unuttun?",
                      text2: "Hatırlat.",
                      press: () async {
                        try {
                          await MyApp.auth
                              .sendPasswordResetEmail(email: _email);
                          Toast.show("Lütfen mailini kontrol et.", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        } catch (e) {
                          Toast.show("Yanlış mail adresi!", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                    RoundedButton(
                      text: "OTURUM AÇ",
                      buttonColor: kPrimaryColor,
                      textColor: Colors.white,
                      press: () {
                        login(_email, _password);
                      },
                    ),
                    AlreadyHaveAnAccountCheck(
                      text1: "Hesabın yok mu?",
                      text2: "Kayıt Ol",
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignupScreen();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }

  void login(String email, String password) async {
    if (MyApp.auth.currentUser == null) {
      try {
        await MyApp.auth
            .signInWithEmailAndPassword(email: email, password: password);
        if (MyApp.auth.currentUser != null) {
          if (MyApp.auth.currentUser.emailVerified) {
            Toast.show("Başarılı oturum açma!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

            bool check = false;

            MyApp.firestore
                .collection('users')
                .get()
                .then((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((element) {
                Map<String, dynamic> data = element.data();
                if (data['user_id'] == MyApp.auth.currentUser.uid) {
                  check = true;
                }
              });

              if (check) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ProductsScreen()),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterScreen(login: true);
                }));
              }
            });
          } else {
            MyApp.auth.signOut();
            Toast.show("Lütfen E-posta Doğrulaması!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show("E-posta veya şifre doğru değil!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      } catch (e) {
        Toast.show("Bir şeyler yanlış gitti!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        debugPrint(e.toString());
      }
    } else {
      Toast.show("Zaten açık bir hesap var!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
