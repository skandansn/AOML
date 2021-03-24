import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:aumsodmll/tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class GroupODList extends StatefulWidget {
  final bool flag;
  GroupODList({Key key, @required this.flag}) : super(key: key);
  @override
  _GroupODListState createState() => new _GroupODListState(flag: flag);
}

class _GroupODListState extends State<GroupODList> {
  @override
  bool flag = true;
  _GroupODListState({this.flag});
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
              final ods = Provider.of<List<GroupOD>>(context);
              var userid = "${snapshot.data.characters}";
              var arr = [];
              ods.forEach((element) {
                if(flag == true){
                  if ((element.head == userid.toString() ||
                        element.faculty == userid.toString() ||
                        element.advisor == userid.toString()) &&
                    element.steps > 0) {
                  arr.add(element);
                }
                }
                else{
                  for (var item in element.stuids)
                  if (item == userid.toString()) {
                  arr.add(element);
                }
                }
              });

              return ListView.builder(
                shrinkWrap: true,
                itemCount: arr.length,
                itemBuilder: (context, index) {
                  return Tile(appl: arr[index],flagType:flag);
                },
              );
            }
        }
      },
    );
  }
}
