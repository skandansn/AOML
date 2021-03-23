import 'package:aumsodmll/formvalid.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final OD appl;
  Tile({this.appl});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: FormVal(od: appl),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
            title: Text(appl.stuNo),
            subtitle: Text('Date: ${appl.date}. Time:  ${appl.time} '),
            onTap: () {
              _showSettingsPanel();
            }),
      ),
    );
  }
}
