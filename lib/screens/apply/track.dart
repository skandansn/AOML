import 'package:aumsodmll/helpers/groupodlist.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/helpers/od_list.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    groupodfun() {
      return GroupODList(flag: false);
    }

    odfun() {
      return ODList(flag: false);
    }

    return MultiProvider(
        providers: [
          StreamProvider<List<OD>>.value(value: DatabaseService().ods),
          StreamProvider<List<GroupOD>>.value(
              value: DatabaseService().groupods),
        ],
        child: Scaffold(
          // backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[600],
            title: (Text("Track Status")),
          ),
          body: Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text("Your Applications"),
            SizedBox(
              height: 5,
            ),
            Flexible(flex: 8, child: odfun()),
            Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Text("Your Group OD Applications"),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 2,
              child: groupodfun(),
            ),
          ]),
        ));
  }
}
