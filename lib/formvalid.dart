import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/od_list.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormVal extends StatefulWidget {
  final OD od;
  FormVal({Key key, @required this.od}) : super(key: key);
  @override
  _FormValState createState() => new _FormValState(od: od);
}

class _FormValState extends State<FormVal> {
  DatabaseService _db = DatabaseService();

  OD od;
  _FormValState({this.od});
  @override
  Widget build(BuildContext context) {
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
              return Container(
                child: Column(
                  children: [
                    Text("Student Name: ${od.stuname}"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Student Roll No: ${od.stuNo}"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Date: ${od.date}"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Time: ${od.stuname}"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Reason for the application: \n${od.description}"),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _db.updateOd(
                              snapshot.data, od.formid, od.steps, true);
                          Navigator.pop(context);
                        },
                        child: Text("Approve the Request")),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _db.updateOd(
                              snapshot.data, od.formid, od.steps, false);
                          Navigator.pop(context);
                        },
                        child: Text("Deny the request "))
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
