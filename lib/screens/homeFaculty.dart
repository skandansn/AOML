import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/od_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return StreamProvider<List<OD>>.value(
        value: DatabaseService().ods,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: (Text("Welcome ${widget.name}")),
              actions: [
                FlatButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Logout"))
              ],
            ),
            body: Row(
              children: <Widget>[
                Expanded(
                  child: ODList(),
                ),
              ],
            )));
  }
}
