import 'package:flutter/material.dart';
import 'package:oyuncubul/home/search_view.dart';

import 'file:///C:/flutter_uygulamalari/oyuncubul/lib/home/home_view.dart';

class TwitterTabbarView extends StatefulWidget {
  @override
  _TwitterTabbarViewState createState() => _TwitterTabbarViewState();
}

class _TwitterTabbarViewState extends State<TwitterTabbarView> {
  bool isHeaderClose = false;
  String _githubPhotoUrl =
      "https://avatars.githubusercontent.com/u/63511980?s=400&u=b09882df5f1d90a707bc5a8144cd7b1e55425cf1&v=4";
  ScrollController scrollController;
  double lastOffset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      print(scrollController);
      if (scrollController.offset <= 0) {
        isHeaderClose = false;
      } else if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = scrollController.offset > lastOffset ? true : false;
      }

      setState(() {
        lastOffset = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: _fabButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomAppBar,
        body: Column(
          children: [
            _containerAppBar,
            Expanded(
              child: TabBarView(
                children: [
                  homeView(scrollController),
                  SearchView(),
                  Text("asdf"),
                  Text("asdf"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _bottomAppBar => BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: _tabbarItems,
      );

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      );

  Widget get _containerAppBar => AnimatedContainer(
      duration: Duration(microseconds: 500),
      height: isHeaderClose ? 0 : 50,
      child: _appBar);

  Widget get _appBar => AppBar(
        elevation: 0,
        centerTitle: false,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 100,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_githubPhotoUrl),
          ),
          Text("Ana Sayfa", style: titleTextStyle),
        ],
      );

  Widget get _tabbarItems => TabBar(tabs: <Widget>[
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.message),
        ),
        Tab(
          icon: Icon(Icons.dashboard),
        ),
        Tab(
          icon: Icon(Icons.settings),
        ),
      ]);
  final titleTextStyle = TextStyle(
      letterSpacing: 1,
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Colors.black);
}
