import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:aumsodmll/helpers/tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ODList extends StatefulWidget {
  final bool flag;
  ODList({Key key, @required this.flag}) : super(key: key);
  @override
  _ODListState createState() => new _ODListState(flag: flag);
}

class _ODListState extends State<ODList> {
  @override
  bool flag = true;
  _ODListState({this.flag});
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService();
    final ScrollController _scrollcontroller = ScrollController();
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
              if (ods != null) {
                ods.forEach((element) {
                  if (flag == true) {
                    if (((element.faculty == userid.toString()) ||
                            (element.advisor == userid.toString())) &&
                        element.steps > 0) {
                      arr.add(element);
                    }
                  } else {
                    if (element.stuid == userid.toString()) {
                      arr.add(element);
                    }
                  }
                });
              }

              return Scrollbar(
                thickness: 10.0,
                controller: _scrollcontroller,
                isAlwaysShown: true,
                child: ListView.builder(
                  controller: _scrollcontroller,
                  itemCount: arr.length,
                  itemBuilder: (context, index) {
                    return Tile(appl: arr[index], flagType: flag);
                  },
                ),
              );
            }
        }
      },
    );
  }
}
