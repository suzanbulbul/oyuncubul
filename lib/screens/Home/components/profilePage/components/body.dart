import 'package:flutter/material.dart';
import 'package:oyuncubul/main.dart';
import 'package:oyuncubul/screens/Home/components/profilePage/FeedBack/feedback_screen.dart';
import 'package:oyuncubul/screens/Home/components/profilePage/components/change_password_screen.dart';
import 'package:oyuncubul/screens/Home/components/profilePage/components/edit_profile_screen.dart';
import 'package:oyuncubul/screens/Welcome/welcome_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Bilgilerim",
            icon: "assets/icons/User_Icon.svg",
            press: () {
              //editprifile git demek
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProfile();
              }));
            },
          ),
          ProfileMenu(
            text: "Şifre Değiş",
            icon: "assets/icons/key.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangePassword();
              }));
            },
          ),
          ProfileMenu(
            text: "Geri Bildirim",
            icon: "assets/icons/freedback.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FeedBack();
              }));
            },
          ),
          ProfileMenu(
            text: "Bildirim Ayaları",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Çıkış Yap",
            icon: "assets/icons/Log_out.svg",
            press: () {
              MyApp.auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
