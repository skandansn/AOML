import 'package:aumsodmll/screens/approve/formvalid.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  Object appl;
  bool flagType;
  Tile({this.appl, this.flagType});
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
    dynamic colour = obj.steps;
    if (colour == -1) {
      colour = Colors.redAccent;
    } else if (colour == 0) {
      colour = Colors.greenAccent;
    } else {
      colour = Colors.yellowAccent;
    }
    void _showSettingsPanel(bool flagType) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: FormVal(od: appl, flagType: flagType),
            );
          });
    }

    if (flag == 2) {
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
              tileColor: colour,
              title: Text(
                obj.stuNos.toString(),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Date: ${obj.date}. Time:  ${obj.time} ',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _showSettingsPanel(flagType);
              }),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
              tileColor: colour,
              title: Text(obj.stuNo.toString(),
                  style: TextStyle(color: Colors.black)),
              subtitle: Text(
                'Date: ${obj.date}. Time:  ${obj.time} ',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _showSettingsPanel(flagType);
              }),
        ),
      );
    }
  }
}
