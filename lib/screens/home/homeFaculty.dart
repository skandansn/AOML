import 'package:aumsodmll/helpers/groupodlist.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/helpers/od_list.dart';
import 'package:aumsodmll/shared/functions.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    groupodfun() {
      return GroupODList(flag: true);
    }

    odfun() {
      return ODList(flag: true);
    }

    return MultiProvider(
        providers: [
          StreamProvider<List<OD>>.value(value: DatabaseService().ods),
          StreamProvider<List<GroupOD>>.value(
              value: DatabaseService().groupods),
        ],
        child: Scaffold(
          // backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[600],
            title: (Text("Welcome ${widget.name} !")),
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
          body: Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text("Individual Applications"),
            SizedBox(
              height: 5,
            ),
            Flexible(flex: 8, child: odfun()),
            Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Text("Your Group OD Applications"),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 2,
              child: groupodfun(),
            ),
          ]),
        ));
  }
}
