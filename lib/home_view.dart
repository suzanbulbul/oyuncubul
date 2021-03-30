import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeView extends StatefulWidget {
  homeView(this.controller);
  final ScrollController controller;

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  String _githubPhotoUrl =
      "https://avatars.githubusercontent.com/u/63511980?s=400&u=b09882df5f1d90a707bc5a8144cd7b1e55425cf1&v=4";
  String _randomImage = "https://picsum.photos/200/300";
  String _dummyText = "Canım kendim seni çok seviyorum. İyi ki kendimsin";
  int defaultTabLength = 4;
  bool isHeaderClose = false;
  double lastOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: _listView,
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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

  Widget get _expandedListView => Expanded(
        child: _listView,
      );

  Widget get _listView => ListView.builder(
        itemCount: 10,
        controller: widget.controller,
        itemBuilder: (context, index) {
          return _listViewCard;
        },
      );

  Widget get _listViewCard => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_randomImage),
          ),
          title: Wrap(
            direction: Axis.horizontal,
            runSpacing: 5,
            children: [
              _listCardTitle("Hello"),
              Text(_dummyText),
              _placeHolderField,
              _footerButtonRow,
            ],
          ),
        ),
      );

  Widget _listCardTitle(String text) => Text(
        text,
        style: titleTextStyle,
      );

  Widget get _placeHolderField => Container(
        height: 100,
        child: Placeholder(),
      );

  Widget get _footerButtonRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_iconLabelButton, _iconLabelButton, _iconLabelButton],
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: [
          Icon(
            Icons.message,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text)
        ],
      );

  Widget get _iconLabelButton => InkWell(child: _iconLabel("1"), onTap: () {});
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black);
