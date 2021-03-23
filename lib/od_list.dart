import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:aumsodmll/tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ODList extends StatefulWidget {
  @override
  _ODListState createState() => _ODListState();
}

class _ODListState extends State<ODList> {
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService();

    return FutureBuilder<String>(
      future: _db.getUserid(), // async work
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              final ods = Provider.of<List<OD>>(context);
              var userid = "${snapshot.data.characters}";
              var arr = [];
              ods.forEach((element) {
                if (((element.faculty == userid.toString()) ||
                        (element.advisor == userid.toString())) &&
                    element.steps != -1) {
                  arr.add(element);
                }
              });

              return ListView.builder(
                itemCount: arr.length,
                itemBuilder: (context, index) {
                  return Tile(appl: arr[index]);
                },
              );
            }
        }
      },
    );
  }
}
