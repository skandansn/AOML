import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:aumsodmll/helpers/tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class ODList extends StatefulWidget {
  var arg;
  final bool flag;
  ODList({Key key, @required this.flag, this.arg}) : super(key: key);
  @override
  _ODListState createState() => new _ODListState(flag: flag, arg: arg);
}

class _ODListState extends State<ODList> {
  bool flag = true;
  var arg;
  _ODListState({this.flag, this.arg});
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService();
    //final ScrollController _scrollcontroller = ScrollController();
    return FutureBuilder<String>(
      future: _db.getUserid(), // async work
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return showScreen_with_resp_to_ConnectionState(snapshot);
      },
    );
  }


  showScreen_with_resp_to_ConnectionState(AsyncSnapshot<String> snapshot)
  {
    final ScrollController _scrollcontroller = ScrollController();
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
                // print("HELLO CHANDRA! ");
                // print(flag);  //TRUE in case of Faculty
                // print("HELLO CHANDRA! ");
                // print(arg); //For now in faculty1@cb.amrita.edu arg == null
                return Tile(appl: arr[index], flagType: flag, sel: arg);
              },
            ),
          );
        }
    }
  }


}
