import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/od_list.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormVal extends StatefulWidget {
  final dynamic od;
  final bool flagType;
  FormVal({Key key, @required this.od, @required this.flagType})
      : super(key: key);
  @override
  _FormValState createState() => new _FormValState(od: od, flagType: flagType);
}

class _FormValState extends State<FormVal> {
  TextEditingController _addreasons = new TextEditingController();
  TextEditingController _getproof = new TextEditingController();
  String proof;
  String reasons;
  Future<void> _addreasonsbox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add reasons '),
            content: TextField(
              controller: _addreasons,
              onChanged: (value) {
                reasons = _addreasons.text;
              },
              decoration: InputDecoration(hintText: "Add reasons"),
            ),
          );
        });
  }

  Future<void> _getproofbox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Get proof'),
            content: TextField(
              controller: _getproof,
              onChanged: (value) {
                if (_getproof.text != null) {
                  proof = _getproof.text.toString();
                }
              },
              decoration: InputDecoration(hintText: "Get proof"),
            ),
          );
        });
  }

  DatabaseService _db = DatabaseService();
  Object od;
  bool flagType;
  _FormValState({this.od, this.flagType});
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
                  child: Column(children: [
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
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    _db.updateOd(snapshot.data, obj.formid,
                                        obj.steps, true, reasons);
                                  },
                                )
                              : Container(),
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.do_not_disturb_alt,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _db.updateOd(snapshot.data, obj.formid,
                                        obj.steps, false, reasons);
                                  },
                                )
                              : Container(),
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _db.reasonsandproof(
                                        snapshot.data, obj.formid, proof);
                                    Navigator.pop(context);
                                  },
                                )
                              : Container(),
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
                    flagType
                        ? Container()
                        : Text(
                            "Requested proofs from the faculties: \n${obj.proof}"),
                    SizedBox(
                      height: 20,
                    ),
                    flagType
                        ? Container()
                        : Text(
                            "Reasons given by the faculty: \n${obj.reasons}"),
                    SizedBox(
                      height: 20,
                    ),
                    flagType
                        ? ElevatedButton(
                            onPressed: () {
                              _getproofbox(context);
                            },
                            child: Text("Request proof"))
                        : Container(),
                    flagType
                        ? ElevatedButton(
                            onPressed: () {
                              _addreasonsbox(context);
                            },
                            child: Text("Add reasons"))
                        : Container(),
                    flagType
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Confirm the approvals/denials"))
                        : Container(),
                  ]),
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
                        height: 20,
                      ),
                      flagType
                          ? Container()
                          : Text(
                              "Requested proofs from the faculties: \n${obj.proof}"),
                      SizedBox(
                        height: 20,
                      ),
                      flagType
                          ? Container()
                          : Text(
                              "Reasons given by the faculty: \n${obj.reasons}"),
                      SizedBox(
                        height: 40,
                      ),
                      flagType
                          ? ElevatedButton(
                              onPressed: () {
                                _getproofbox(context);
                              },
                              child: Text("Request proof"))
                          : Container(),
                      flagType
                          ? ElevatedButton(
                              onPressed: () {
                                _addreasonsbox(context);
                              },
                              child: Text("Add reasons"))
                          : Container(),
                      Row(
                        children: [
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    _db.updateOd(snapshot.data, obj.formid,
                                        obj.steps, true, reasons);
                                    Navigator.pop(context);
                                  },
                                )
                              : Container(),
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.do_not_disturb_alt,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _db.updateOd(snapshot.data, obj.formid,
                                        obj.steps, false, reasons);
                                    Navigator.pop(context);
                                  },
                                )
                              : Container(),
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    print(proof);
                                    _db.reasonsandproof(
                                        snapshot.data, obj.formid, proof);
                                    Navigator.pop(context);
                                  },
                                )
                              : Container(),
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
