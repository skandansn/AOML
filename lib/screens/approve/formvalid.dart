import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/od_list.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormVal extends StatefulWidget {
  final dynamic od;
  FormVal({Key key, @required this.od}) : super(key: key);
  @override
  _FormValState createState() => new _FormValState(od: od);
}

class _FormValState extends State<FormVal> {
  DatabaseService _db = DatabaseService();
  Object od;
  // GroupOD god;
  _FormValState({this.od});
  @override
  Widget build(BuildContext context) {
    GroupOD applobjgrp;
    int flag = 1;
    OD applobjind;
    if (od is GroupOD) {
      applobjgrp = od;
      flag = 2;
    } else {
      applobjind = od;
    }
    var obj;
    if (flag == 1) {
      obj = applobjind;
    } else {
      obj = applobjgrp;
    }
    if (obj is GroupOD) {
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
                      Text("Student Names:"),
                      for (var item in obj.stunames) Text(item),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Student Roll Nos:"),
                      for (var item in obj.stuNos)
                        Row(
                          children: [
                            Text(item),
                            IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                _db.updateOd(
                                    snapshot.data, obj.formid, obj.steps, true);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.do_not_disturb_alt,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _db.updateOd(snapshot.data, obj.formid,
                                    obj.steps, false);
                              },
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Date: ${obj.date}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Time: ${obj.time}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Reason for the application: \n${obj.description}"),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Confirm the approvals/denials"))
                    ],
                  ),
                );
              }
          }
        },
      );
    } else {
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
                      Text("Application Type: ${obj.type}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Student Name: ${obj.stuname}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Student Roll No: ${obj.stuNo}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Date: ${obj.date}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Time: ${obj.time}"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Reason for the application: \n${obj.description}"),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              _db.updateOd(
                                  snapshot.data, obj.formid, obj.steps, true);
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.do_not_disturb_alt,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _db.updateOd(
                                  snapshot.data, obj.formid, obj.steps, false);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
          }
        },
      );
    }
  }
}
