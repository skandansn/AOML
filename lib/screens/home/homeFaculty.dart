import 'package:aumsodmll/shared/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeFaculty extends StatelessWidget {
  String name = "";
  HomeFaculty(String names) {
    this.name = names;
  }

  // @override
  // _HomeFacultyState createState() => _HomeFacultyState();

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0.1,
        title: (Text("Welcome $name !")),
        actions: [
          TextButton.icon(
              key: Key("logout-button"),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () async {
                confirmLogoutBox(context);
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              Card(
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                elevation: 8.0,
                child: Container(
                  // margin:
                  //     new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    key: Key("approve-od"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: Icon(
                        Icons.approval,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Approve/deny application',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/approve");
                    },
                  ),
                ),
              ),
              Card(
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                elevation: 8.0,
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    key: Key("grantgrp"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: Icon(
                        Icons.group,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Grant Group OD option',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/grantgrpod');
                    },
                  ),
                ),
              ),
              Card(
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                elevation: 8.0,
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    key: Key("faq"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: Icon(
                        Icons.question_answer,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'FAQs',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/faq");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
