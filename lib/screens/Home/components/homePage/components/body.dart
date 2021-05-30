import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oyuncubul/main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Status> list;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<QuerySnapshot>(
                  future: MyApp.firestore.collection("status").get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      list = [];

                      getStatus() async {
                        snapshot.data.docs.forEach((doc) {
                          Status s = new Status(
                              doc.data()["detail"],
                              doc.data()["subject"],
                              doc.data()["created_date"]);
                          list.add(s);
                        });

                        list.sort((a, b) => b._time.compareTo(a._time));
                      }

                      getStatus();

                      return Expanded(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return _listViewCard(list[index]);
                          },
                        ),
                      );
                    }
                    return LinearProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _listViewCard(Status status) => Card(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: null),
          title: Wrap(
            runSpacing: 25,
            direction: Axis.vertical,
            children: [
              Text(status._subject, style: titleTextStyle),
              Text(status._detail),
              Text(status._time.toDate().toString()),
            ],
          ),
        ),
      );
}

class Status {
  String _detail;
  String _subject;
  Timestamp _time;

  Status(this._detail, this._subject, this._time);

  @override
  String toString() {
    return 'Status{_detail: $_detail, _subject: $_subject, _time: $_time}';
  }

  String get detail => _detail;

  set detail(String value) {
    _detail = value;
  }

  String get subject => _subject;

  set subject(String value) {
    _subject = value;
  }

  Timestamp get time => _time;

  set time(Timestamp value) {
    _time = value;
  }
}

final titleTextStyle = TextStyle(
  letterSpacing: 1,
  fontSize: 20,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
