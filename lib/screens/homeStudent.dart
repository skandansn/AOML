import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeStudent extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  final DatabaseService _db = DatabaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: (Text("AOML Student Portal")),
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Logout"))
          ],
        ));
  }
}
