import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:my_fit/screens/Login/sign_in_screen.dart';
import 'package:my_fit/screens/SignUp/components/background.dart';
import 'package:my_fit/screens/SignUp/register_screen.dart';
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
  void initState() {
    super.initState();
    MyApp.auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

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
          return BackGround(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * .25,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    RoundedInputField(
                      text: "Your Email",
                      onChanged: (val) {
                        _email = val;
                      },
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                    ),
                    RoundedPasswordField(
                      onChanged: (val) {
                        _password = val;
                      },
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      press: () {
                        signup(_email, _password);
                      },
                      textColor: Colors.white,
                      buttonColor: kPrimaryColor,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    AlreadyHaveAnAccountCheck(
                      text1: "Do you have an account?",
                      text2: "Sign In",
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SigninScreen();
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
        return LinearProgressIndicator();
      },
    );
  }

  void signup(String email, String password) async {
    try {
      await MyApp.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await MyApp.auth.currentUser.sendEmailVerification();

      if (MyApp.auth.currentUser.emailVerified) {
        Toast.show("SignUp Successfull!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => RegisterScreen()),
            (Route<dynamic> route) => false);
      } else {
        Toast.show("We send email. Please verify your account.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        await MyApp.auth.signOut();
      }
    } catch (e) {
      Toast.show(
          "An account for this email already exists or Something went wrong!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
      debugPrint(e.toString());
    }
  }
}
