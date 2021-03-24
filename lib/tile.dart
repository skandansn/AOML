import 'package:aumsodmll/screens/approve/formvalid.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  Object appl;
  Tile({this.appl});

  @override
  Widget build(BuildContext context) {
    GroupOD applobjgrp;
    int flag = 1;
    OD applobjind;
    if (appl is GroupOD) {
      applobjgrp = appl;
      flag = 2;
    } else {
      applobjind = appl;
    }
    var obj;
    if (flag == 1) {
      obj = applobjind;
    } else {
      obj = applobjgrp;
    }
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: FormVal(od: appl),
            );
          });
    }

    if (flag == 2) {
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
              title: Text(obj.stuNos.toString()),
              subtitle: Text('Date: ${obj.date}. Time:  ${obj.time} '),
              onTap: () {
                _showSettingsPanel();
              }),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
              title: Text(obj.stuNo.toString()),
              subtitle: Text('Date: ${obj.date}. Time:  ${obj.time} '),
              onTap: () {
                _showSettingsPanel();
              }),
        ),
      );
    }
  }
}
