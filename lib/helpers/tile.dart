//import 'dart:io';

import 'package:aumsodmll/models/faq.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/formvalid.dart';
import 'package:aumsodmll/models/od.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Tile extends StatelessWidget {
  final Object appl;
  final String sel;
  final bool flagType;
  final String userid;
  final String userNo;
  final bool userType;

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController anscont = TextEditingController();
  final DatabaseService _db = DatabaseService();
  Tile(
      {this.appl,
      this.flagType,
      this.userid,
      this.userNo,
      this.userType,
      this.sel});

  @override
  Widget build(BuildContext context) {
    GroupOD applobjgrp;
    int flag = 1;
    OD applobjind;
    FAQClass faqlist;
    if (appl is GroupOD) {
      applobjgrp = appl;
      flag = 2;
    } else if (appl is FAQClass) {
      flag = 3;
      faqlist = appl;
    } else {
      flag = 1;
      applobjind = appl;
    }
    var obj;
    if (flag == 1) {
      obj = applobjind;
    } else if (flag == 2) {
      obj = applobjgrp;
    } else if (flag == 3) {
      obj = faqlist;
    }
    dynamic symbol;
    var pinsymbol;
    if (obj.runtimeType == OD) {
      symbol = obj.steps;
    } else if (obj.runtimeType == GroupOD) {
      for (int i = 0; i < obj.stuids.length; i++) {
        if (obj.stuids[i] == userid) {
          symbol = obj.steps[i];
        }
      }
    } else if (obj.runtimeType is FAQClass) {
      symbol = null;
    }
    var color;
    if (symbol == -1) {
      symbol = Icons.do_disturb_on_rounded;
      color = Colors.redAccent;
    } else if (symbol == 0) {
      symbol = Icons.check_circle_rounded;
      color = Colors.greenAccent;
    } else {
      symbol = Icons.timelapse;
      color = Colors.white;
    }
    void _showFormVal(bool flagType) {
      showModalBottomSheet(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          elevation: 8,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: FormVal(od: appl, flagType: flagType),
            );
          });
    }

    void _showFAQitem() {
      showModalBottomSheet(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          elevation: 8,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    for (var item in obj.answers)
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9)),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              title: Text(
                                item.values.first,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '\nAnswered by: ${item.keys.first}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Enter your answer",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Card(
                        key: Key('ans-field'),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        elevation: 8.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: FormBuilderTextField(
                            name: "ans",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            controller: anscont,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Answer"),
                          ),
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      !userType
                          ? IconButton(
                              icon: pinsymbol,
                              onPressed: () {
                                _db.pinOrUnpinFaq(obj.formid);
                                final snackBar = SnackBar(
                                    content: Text(
                                        'The FAQ item has been pinned/unpinned.'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              })
                          : Container(),
                      ElevatedButton(
                          key: Key('submit-field'),
                          style: buttonStyle,
                          onPressed: () {
                            _formKey.currentState.save();
                            if (_formKey.currentState.validate()) {
                              var ans = {userNo: anscont.text};
                              _db.addAnswerFaq(obj.formid, userid, ans);
                              final snackBar = SnackBar(
                                  content: Text('Your answer has been added!'));
                              anscont.clear();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Submit "))
                    ]),
                  ],
                ),
              ),
            );
          });
    }

    if (flag == 2) {
      var selectedcolor = Color.fromRGBO(64, 75, 96, .9);
      if (sel == '${obj.formid}') {
        print("s");
        selectedcolor = Colors.teal;
      }
      List facSteps = obj.facSteps;
      bool grpDisplayFlag = false;
      facSteps.forEach((element) {
        if (element != 0) {
          grpDisplayFlag = true;
        }
      });
      if (flagType == false || grpDisplayFlag) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: selectedcolor),
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Icon(symbol, color: color),
                  ),
                  // tileColor: colour,
                  title: Text(
                    obj.stuNos.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '\nDate: ${obj.date}\nType:  ${obj.type} ',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 30.0),
                  onTap: () {
                    _showFormVal(flagType);
                  }),
            ),
          ),
        );
      } else {
        return Container();
      }
    } else if (flag == 1) {
      var selectedcolor = Color.fromRGBO(64, 75, 96, .9);
      if (sel == '${obj.formid}') {
        selectedcolor = Colors.teal;
      }

      if (!(obj.type == "GroupOd") || !(flagType == false)) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: selectedcolor),
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Icon(symbol, color: color),
                  ),
                  // tileColor: colour,
                  title: Text(
                    obj.stuNo.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '\nDate: ${obj.date}\nType:  ${obj.type} ',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 30.0),
                  onTap: () {
                    _showFormVal(flagType);
                  }),
            ),
          ),
        );
      } else {
        return Container();
      }
    } else {
      if (obj.pinned == true) {
        pinsymbol =
            Icon(Icons.push_pin_outlined, color: Colors.green, size: 30.0);
      } else {
        pinsymbol =
            Icon(Icons.push_pin_outlined, color: Colors.white, size: 30.0);
      }
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                // trailing: IconButton(
                //     icon: Icon(Icons.push_pin_outlined,
                //         color: Colors.white, size: 30.0),
                //     onPressed: () {}),
                leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: IconButton(
                              icon: Icon(Icons.arrow_upward),
                              color: color,
                              onPressed: () {
                                _db.upvoteFaq(obj.formid, userid);
                              }),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${obj.upvotes}",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )),
                // tileColor: colour,
                title: Text(
                  obj.question.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '\nAsked by: ${obj.stuNo}\nTime:  ${obj.time} ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  _showFAQitem();
                }),
          ),
        ),
      );
    }
  }
}
