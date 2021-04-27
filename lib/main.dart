import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/screens/Home/screens/product/products_screen.dart';
import 'package:oyuncubul/screens/Welcome/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oyuncu Bul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor)),
      home: MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // herhangi bir hata
        if (snapshot.hasError) {
          return Text("Opss! Yanlış giden bişeyler var.");
        }

        // Kullanıcı hangi sayfaya yönlendirilicek
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp.auth.currentUser == null
              ? WelcomeScreen()
              : ProductsScreen();
        }

        // başlatmanın tamamlanmasını beklerken bir şey gösterir
        return CircularProgressIndicator();
      },
    );
  }
}
