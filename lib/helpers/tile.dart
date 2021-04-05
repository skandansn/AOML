import 'package:aumsodmll/shared/formvalid.dart';
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
    dynamic symbol = obj.steps;
    var color;
    if (symbol == -1) {
      symbol = Icons.do_disturb_alt_outlined;
      color = Colors.redAccent;
    } else if (symbol == 0) {
      symbol = Icons.check;
      color = Colors.greenAccent;
    } else {
      symbol = Icons.timelapse;
      color = Colors.white;
    }
    void _showFormVal(bool flagType) {
      showModalBottomSheet(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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
          margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
          child: ListTile(
              // tileColor: symbol,
              title: Text(
                obj.stuNos.toString(),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Date: ${obj.date}. Type:  ${obj.type} ',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _showFormVal(flagType);
              }),
        ),
      );
    } else {
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
                  'Date: ${obj.date}\nType:  ${obj.type} ',
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
    }
  }
}
