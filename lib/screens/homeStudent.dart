import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeStudent extends StatelessWidget {
  String name = "";
  HomeStudent(String names) {
    print(names);
    this.name = names;
  }

  final AuthService _auth = AuthService();
  @override
  final DatabaseService _db = DatabaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // backgroundColor: Colors.lightBlueAccent,
        title: (Text("Welcome $name")),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.work),
              title: Text('Apply for an OD'),
              onTap: () {
                Navigator.pushNamed(context, "/od");
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.medical_services_sharp),
              title: Text('Apply for a ML'),
              onTap: () {
                Navigator.pushNamed(context, "/ml");
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Text('Apply for a day pass'),
              onTap: () {
                Navigator.pushNamed(context, "/daypass");
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Apply for a home pass'),
              onTap: () {
                Navigator.pushNamed(context, "/homepass");
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Track status'),
              onTap: () {
                Navigator.pushNamed(context, "/track");
              },
            ),
          ),
        ],
      ),
    );
  }
}
