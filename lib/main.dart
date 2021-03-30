import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/tabbar_view.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Material App",
      home: TwitterTabbarView(),
      theme: ThemeData.light().copyWith(
          appBarTheme:
              AppBarTheme(color: Theme.of(context).scaffoldBackgroundColor),
          tabBarTheme: TabBarTheme(
              labelColor: CupertinoColors.activeBlue,
              unselectedLabelColor: CupertinoColors.inactiveGray)),
    );
  }
}
