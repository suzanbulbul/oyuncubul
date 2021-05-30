import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oyuncubul/components/constants.dart';
import 'package:oyuncubul/screens/Home/components/homePage/home_screen.dart';
import 'package:oyuncubul/screens/Home/components/profilePage/profile_screen.dart';
import 'package:oyuncubul/screens/Home/components/statusPage/status_screen.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor)),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'OYUNCUBUL',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset("assets/icons/notification.svg"),
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home, color: Colors.white)),
                Tab(icon: Icon(Icons.post_add, color: Colors.white)),
                Tab(icon: Icon(Icons.message, color: Colors.white)),
                Tab(icon: Icon(Icons.settings, color: Colors.white)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              StatusScreen(),
              Icon(Icons.directions_bike),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
