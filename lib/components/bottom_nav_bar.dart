import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oyuncubul/main.dart';


import 'constants.dart';

class BottomNavBar extends StatelessWidget {
  final bool history;
  final bool home;
  final bool settings;

  const BottomNavBar({
    Key key,
    this.history = false,
    this.home = true,
    this.settings = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (!history) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return null;
                    },
                  ));
                }
              },
              child: BottomNavItem(
                title: "History",
                svgSrc: "assets/icons/icons8planner.svg",
                isActive: history,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (!home) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MainHomeScreen();
                    },
                  ));
                }
              },
              child: BottomNavItem(
                title: "Home",
                svgSrc: "assets/icons/icons8gym.svg",
                isActive: home,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (!settings) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return null;
                    },
                  ));
                }
              },
              child: BottomNavItem(
                title: "Settings",
                svgSrc: "assets/icons/icons8settings.svg",
                isActive: settings,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String title;
  final String svgSrc;
  final Function press;
  final bool isActive;

  const BottomNavItem({
    Key key,
    this.title,
    this.svgSrc,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgSrc,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: isActive ? kActiveIconColor : kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
