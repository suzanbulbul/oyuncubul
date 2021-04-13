import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fit/components/already_have_an_account_check.dart';
import 'package:my_fit/components/constants.dart';
import 'package:my_fit/components/rounded_button.dart';
import 'package:my_fit/components/rounded_input_field.dart';
import 'package:my_fit/components/rounded_password_field.dart';
import 'package:my_fit/main.dart';
import 'package:my_fit/screens/Home/home_screen.dart';
import 'package:my_fit/screens/Login/components/background.dart';
import 'package:my_fit/screens/SignUp/register_screen.dart';
import 'package:my_fit/screens/SignUp/sign_up_screen.dart';
import 'package:toast/toast.dart';

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
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Upss! Something went wrong");
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
                      "LOGIN",
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
                      text: "Your Email",
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
                      text1: "Forget your password?",
                      text2: "Remember.",
                      press: () async {
                        try {
                          await MyApp.auth
                              .sendPasswordResetEmail(email: _email);
                          Toast.show("Please check your email!", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        } catch (e) {
                          Toast.show("Wrong e-mail address!", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      buttonColor: kPrimaryColor,
                      textColor: Colors.white,
                      press: () {
                        login(_email, _password);
                      },
                    ),
                    AlreadyHaveAnAccountCheck(
                      text1: "Don't have an account?",
                      text2: "Sign Up",
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
            Toast.show("Success signin!", context,
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterScreen(login: true);
                }));
              }
            });
          } else {
            MyApp.auth.signOut();
            Toast.show("Please Email Verification!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show("Email or password is not correct!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      } catch (e) {
        Toast.show("Something went wrong!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        debugPrint(e.toString());
      }
    } else {
      Toast.show("There is already an open account!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
