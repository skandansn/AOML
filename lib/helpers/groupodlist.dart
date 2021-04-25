import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:aumsodmll/helpers/tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GroupODList extends StatefulWidget {
  final bool flag;
  var arg;
  GroupODList({Key key, @required this.flag, this.arg}) : super(key: key);
  @override
  _GroupODListState createState() =>
      new _GroupODListState(flag: flag, arg: arg);
}

class _GroupODListState extends State<GroupODList> {
  bool flag = true;
  var arg;
  final ScrollController _scrollcontroller = ScrollController();

  _GroupODListState({this.flag, this.arg});
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
              final ods = Provider.of<List<GroupOD>>(context);
              var userid = "${snapshot.data.characters}";
              var arr = [];
              if (ods != null) {
                ods.forEach((element) {
                  if (flag == true) {
                    if (userid.toString() == element.faculty) {
                      arr.add(element);
                    }
                  } else {
                    for (var item in element.stuids) {
                      if (item == userid.toString()) {
                        arr.add(element);
                      }
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
                  shrinkWrap: true,
                  itemCount: arr.length,
                  itemBuilder: (context, index) {
                    return Tile(
                      appl: arr[index],
                      flagType: flag,
                      sel: arg,
                      userid: '${snapshot.data}',
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }
}
