import 'package:aumsodmll/groupodlist.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/od_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomeFaculty extends StatefulWidget {
  String name = "";
  HomeFaculty(String names) {
    this.name = names;
  }

  @override
  _HomeFacultyState createState() => _HomeFacultyState();
}

class _HomeFacultyState extends State<HomeFaculty> {
  final AuthService _auth = AuthService();

  @override
  final DatabaseService _db = DatabaseService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    groupodfun() {
      return GroupODList(flag: true);
    }

    odfun() {
      return ODList(flag: true);
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
            // backgroundColor: Colors.lightBlueAccent,
            title: (Text("Welcome ${widget.name}")),
            actions: [
              FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"))
            ],
          ),
          body: Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text("Individual Applications"),
            SizedBox(
              height: 5,
            ),
            Expanded(child: odfun()),
            Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Text("Group OD Applications"),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: groupodfun(),
            ),
          ]),
        ));
  }
}
