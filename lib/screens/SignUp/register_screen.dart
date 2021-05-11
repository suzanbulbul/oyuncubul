import 'package:flutter/material.dart';
import 'package:oyuncubul/screens/SignUp/components/register_body.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  bool login;
  RegisterScreen({this.login = false});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        login: widget.login,
      ),
    );
  }
}
