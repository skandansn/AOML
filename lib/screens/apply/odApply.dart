import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OD extends StatefulWidget {
  @override
  _ODState createState() => _ODState();
}

class _ODState extends State<OD> {
  DatabaseService _db = DatabaseService();
  TextEditingController datecont = new TextEditingController();
  TextEditingController timecont = new TextEditingController();
  TextEditingController descriptioncont = new TextEditingController();
  TextEditingController typecont = new TextEditingController();
  TextEditingController proofcont = new TextEditingController();
  var advisordropname = "Select your advisor";
  var facultydropname = "Select your faculty";
  var clickedidad = "";
  var clickedidfac = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _db.facultyList(), // async work
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              var userid = "${snapshot.data.first}";
              var list = snapshot.data;
              list.removeAt(0);
              var stuname = list[0];
              list.removeAt(0);
              var stuNo = list[0];
              list.removeAt(0);
              List<String> namelist = [];
              list.forEach((element) {
                namelist.add(element["name"]);
              });
              List<String> idlist = [];
              list.forEach((element) {
                idlist.add(element["userid"]);
              });
              return Scaffold(
                appBar: AppBar(
                  title: Text("Applying"),
                ),
                body: Column(
                  children: [
                    DropdownButton<String>(
                      hint: Text(advisordropname),
                      items: namelist.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              clickedidad = idlist[namelist.indexOf(value)];
                              advisordropname = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    // TextFormField(
                    //   controller: advisorcont,
                    //   decoration:
                    //       textInputDecoration.copyWith(hintText: "Advisor ID"),
                    // ),
                    DropdownButton<String>(
                      hint: Text(facultydropname),
                      items: namelist.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              clickedidfac = idlist[namelist.indexOf(value)];
                              print(clickedidad);
                              facultydropname = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                    TextFormField(
                      controller: datecont,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Date"),
                    ),
                    TextFormField(
                      controller: timecont,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Time"),
                    ),
                    TextFormField(
                      controller: descriptioncont,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Description"),
                    ),
                    TextFormField(
                      controller: typecont,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Type"),
                    ),
                    TextFormField(
                      controller: proofcont,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Proof"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _db.applyod(
                              userid,
                              stuname,
                              stuNo,
                              clickedidfac,
                              clickedidad,
                              datecont.text,
                              timecont.text,
                              descriptioncont.text,
                              typecont.text,
                              proofcont.text);
                          Navigator.pop(context);
                        },
                        child: Text("Submit "))
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
