import 'dart:io';
import 'dart:ui';

import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/updateForm.dart';
import 'package:aumsodmll/shared/PdfPreviewScreen.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;

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
  bool done = false;
  String reasons;
  Future<void> _addreasonsbox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            elevation: 8,
            title: Text('Add reasons ',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: _addreasons,
                    onChanged: (value) {
                      reasons = _addreasons.text;
                    },
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: textInputDecoration.copyWith(
                      labelText: "Reasons",
                    )),
                ElevatedButton(
                    onPressed: () {
                      done = true;
                      Navigator.pop(context);
                    },
                    style: buttonStyle,
                    child: Text("Validate"))
              ],
            ),
          );
        });
  }

  String _url;
  Future<void> _getproofbox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            elevation: 8,
            title: Text('Get proof ',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    controller: _getproof,
                    onChanged: (value) {
                      if (_getproof.text != null) {
                        proof = _getproof.text.toString();
                      }
                    },
                    decoration: textInputDecoration.copyWith(
                      labelText: "Reasons",
                    )),
                ElevatedButton(
                    onPressed: () {
                      done = true;
                      Navigator.pop(context);
                    },
                    style: buttonStyle,
                    child: Text("Validate"))
              ],
            ),
          );
        });
  }

  DatabaseService _db = DatabaseService();
  Object od;
  dynamic steps;
  var color;
  bool flagType;

  _FormValState({this.od, this.flagType});
  @override
  final pdf = pw.Document();

  writeOnPdf(int flagpdf) {
    GroupOD applobjgrp;
    int flag = 1;
    OD applobjind;
    if (od is GroupOD) {
      applobjgrp = od;
      flag = 2;
    } else {
      applobjind = od;
    }
    var objP;
    if (flag == 1) {
      objP = applobjind;
    } else {
      objP = applobjgrp;
    }
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        if (flagpdf == 1) {
          return <pw.Widget>[
            pw.Header(level: 0, child: pw.Text('Individual')),
            pw.Paragraph(text: "Application Type : ${objP.type}"),
            pw.Paragraph(text: "Student Name : ${objP.stuname}"),
            pw.Paragraph(text: "Student Roll Number : ${objP.stuNo}"),
            pw.Paragraph(text: "Date : ${objP.date}"),
            pw.Paragraph(text: "Time : ${objP.time}"),
            pw.Paragraph(text: "Description : ${objP.description}"),
            pw.Paragraph(text: "Reasons : ${objP.reasons}"),
            pw.Paragraph(text: "Proof Requested : ${objP.proofreq}"),
          ];
        } else {
          return <pw.Widget>[
            pw.Header(level: 0, child: pw.Text('Group')),
            pw.Paragraph(text: "Student Names :"),
            for (int i = 0; i < objP.stuNos.length; i++)
              pw.Paragraph(text: "${objP.stunames[i]}"),
              pw.Paragraph(text: "Student Numbers :"),
            for (int i = 0; i < objP.stuNos.length; i++)
              pw.Paragraph(text: "${objP.stuNos[i]}"),
            pw.Paragraph(text: "Date : ${objP.date}"),
            pw.Paragraph(text: "Time : ${objP.time}"),
            pw.Paragraph(text: "Description : ${objP.description}"),
          ];
        }
      },
    ));
  }

  Future savePdf(String path) async {
    Directory documentDirectory = await getExternalStorageDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/$path.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          elevation: 8,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: UpdateForm(od:od),
            );
          });
    }

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
                for (int i = 0; i < obj.stuids.length; i++) {
                  if (obj.stuids[i] == '${snapshot.data}') {
                    steps = obj.steps[i];
                  }
                }
                switch (steps) {
                  case -1:
                    color = Colors.red;
                    break;
                  case 0:
                    color = Colors.green;

                    break;
                  default:
                    color = Colors.white;
                }
                return Container(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Student Name:",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ])),
                    for (var item in obj.stunames)
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(text: " $item", style: TextStyle(color: color))
                      ])),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Student Nos:",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ])),
                    for (int i = 0; i < obj.stuNos.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: obj.stuNos[i],
                                style: TextStyle(color: color))
                          ])),
                          flagType
                              ? obj.facSteps[i] == 1 && obj.steps[i] > 0
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () async {
                                        var steps = obj.steps;
                                        var facSteps = obj.facSteps;
                                        facSteps[i] = 0;

                                        steps[i] -= 1;
                                        FirebaseFirestore.instance
                                            .collection("groupods")
                                            .doc(obj.formid)
                                            .update({
                                          "steps": steps,
                                          "facSteps": facSteps
                                        });
                                        Navigator.pop(context);
                                      },
                                    )
                                  : Container()
                              : Container(),
                          flagType
                              ? obj.facSteps[i] == 1 && obj.steps[i] > 0
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.do_not_disturb_alt,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        var steps = obj.steps;
                                        var facSteps = obj.facSteps;
                                        facSteps[i] = 0;

                                        steps[i] = -1;
                                        FirebaseFirestore.instance
                                            .collection("groupods")
                                            .doc(obj.formid)
                                            .update({
                                          "steps": steps,
                                          "facSteps": facSteps
                                        });
                                        Navigator.pop(context);
                                      },
                                    )
                                  : Container()
                              : Container(),
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Date:",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: " ${obj.date}", style: TextStyle(color: color))
                    ])),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Time:",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: " ${obj.time}", style: TextStyle(color: color))
                    ])),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Description:",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: " ${obj.description}",
                          style: TextStyle(color: color))
                    ])),
                    SizedBox(
                      height: 20,
                    ),
                    "${obj.proof}" != "null" && "${obj.proof}" != ""
                        ? ElevatedButton(
                            style: buttonStyle,
                            child: Text(
                              "View proof",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              _url = "${obj.proof}";
                              if (await canLaunch(_url))
                                await launch(_url);
                              else
                                throw "Could not launch $_url";
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    flagType
                        ? ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Confirm the approvals/denials"))
                        : IconButton(
                                  icon: const Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    print(obj.formid);
                                    writeOnPdf(flag);
                                    await savePdf(obj.formid);

                                    Directory documentDirectory =
                                        await getExternalStorageDirectory();
                                    String pathId = obj.formid;
                                    String documentPath =
                                        documentDirectory.path;

                                    String fullPath =
                                        "$documentPath/$pathId.pdf";

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PdfPreviewScreen(
                                                  path: fullPath,
                                                )));
                                  },
                                ),
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
                steps = obj.steps;
                switch (steps) {
                  case -1:
                    color = Colors.red;
                    break;
                  case 0:
                    color = Colors.green;

                    break;
                  default:
                    color = Colors.white;
                }
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Application Type:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ${obj.type}",
                            style: TextStyle(color: color))
                      ])),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Student Name:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ${obj.stuname}",
                            style: TextStyle(color: color))
                      ])),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Student Roll No:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ${obj.stuNo}",
                            style: TextStyle(color: color))
                      ])),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Date:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ${obj.date}",
                            style: TextStyle(color: color))
                      ])),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Time:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ${obj.time}",
                            style: TextStyle(color: color))
                      ])),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Description:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ${obj.description}",
                            style: TextStyle(color: color))
                      ])),
                      SizedBox(
                        height: 20,
                      ),
                      "${obj.proof}" != "null" && "${obj.proof}" != ""
                          ? ElevatedButton(
                              style: buttonStyle,
                              child: Text(
                                "View proof",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                _url = "${obj.proof}";
                                if (await canLaunch(_url))
                                  await launch(_url);
                                else
                                  throw "Could not launch $_url";
                              },
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      flagType
                          ? Container()
                          : RichText(
                              text: TextSpan(children: [
                              TextSpan(
                                text: "Reasons given by the faculty:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: " ${obj.reasons}",
                                  style: TextStyle(color: color))
                            ])),
                      SizedBox(
                        height: 20,
                      ),
                      flagType
                          ? Container()
                          : RichText(
                              text: TextSpan(children: [
                              TextSpan(
                                text: "Proof requested by the faculty:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: " ${obj.proofreq}",
                                  style: TextStyle(color: color))
                            ])),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  onPressed: () async {
                                    await _addreasonsbox(context);
                                    if (done == true) {
                                      reasons =
                                          "Faculty ID: ${snapshot.data}\nDetails:$reasons";
                                      _db.updateOd(snapshot.data, obj.formid,
                                          obj.steps, true, reasons);
                                      Navigator.pop(context);
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'Application has been approved.'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      done = false;
                                    }
                                  },
                                )
                              : obj.steps > 0 ? 
                              IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    return showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text("Cancel OD/Leave/ML"),
                                        content: Text(
                                            "Are you sure you want to cancel your OD/Leave/ML"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('ods')
                                                  .doc(obj.formid)
                                                  .delete();
                                              Navigator.of(ctx).pop();
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("No"),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                  : Container(),
                          flagType
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.do_not_disturb_alt,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await _addreasonsbox(context);
                                    if (done == true) {
                                      reasons =
                                          "Faculty ID: ${snapshot.data}\nDetails:$reasons";
                                      _db.updateOd(snapshot.data, obj.formid,
                                          obj.steps, false, reasons);
                                      Navigator.pop(context);
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'Application has been denied.'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      done = false;
                                    }
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    writeOnPdf(flag);
                                    await savePdf(obj.formid);

                                    Directory documentDirectory =
                                        await getExternalStorageDirectory();
                                    String pathId = obj.formid;
                                    String documentPath =
                                        documentDirectory.path;

                                    String fullPath =
                                        "$documentPath/$pathId.pdf";

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PdfPreviewScreen(
                                                  path: fullPath,
                                                )));
                                  },
                                ),
                          flagType
                              ? IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    await _getproofbox(context);

                                    if (done == true) {
                                      proof =
                                          "Faculty ID: ${snapshot.data}\nDetails:$proof";
                                      _db.reasonsandproof(
                                          snapshot.data, obj.formid, proof);
                                      Navigator.pop(context);
                                      final snackBar = SnackBar(
                                          content: Text(
                                              'Additional proof request has been sent to the applicant.'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      done = false;
                                    }
                                  },
                                )
                              : obj.steps > 0 ? 
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _showSettingsPanel(),
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
