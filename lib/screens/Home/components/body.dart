import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    //sayfadaki her hareketi getirir
    scrollController.addListener(
      () {
        print(scrollController.offset);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _expandedListview,
      ],
    );
  }

  Widget get _expandedListview => Expanded(child: _listView);

  Widget get _listView => ListView.builder(
        itemCount: 20,
        controller: scrollController,
        itemBuilder: (context, index) {
          return _listViewCard;
        },
      );

  Widget get _listViewCard => Card(
        child: ListTile(
          title: Wrap(
            children: [
              _listCardTitle("hello"),
              Text("kadlssifidsifşdçifsç"),
            ],
          ),
        ),
      );

  Widget _listCardTitle(String text) => Text(
        text,
        style: titleTextStyle,
      );
}

final titleTextStyle = TextStyle(
  letterSpacing: 1,
  fontSize: 20,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
