import 'package:aumsodmll/shared/functions.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeStudent extends StatelessWidget {
  String name = "";
  HomeStudent(String names) {
    this.name = names;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: (Text("Welcome $name !")),
        actions: [
          TextButton.icon(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () async {
                confirmLogoutBox(context);
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
              title: Text('Apply for an OD/ML/Daypass/Homepass'),
              onTap: () {
                Navigator.pushNamed(context, "/od");
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
