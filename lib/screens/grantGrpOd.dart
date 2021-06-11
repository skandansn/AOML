import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GrantGrpOD extends StatelessWidget {
  DatabaseService _db = DatabaseService();
  final _formKey = GlobalKey<FormBuilderState>();
  var clickedstuid = "";
  var studentdropname = "Select the student";
  var clickedform;
  TextEditingController datecont = new TextEditingController();
  TextEditingController numcont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _db.getUsersList(true), // async work
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        print("HELLO CHANDRA");
        print(context);
        return showScreen_with_resp_to_ConnectionState(context,snapshot);
      },
    );
  }

  showScreen_with_resp_to_ConnectionState(BuildContext context,AsyncSnapshot<List> snapshot)
  {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Loading();
      default:
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        else {
          var list = snapshot.data;

          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          list.removeAt(0);
          List<String> namelist = [];
          List<String> formsList = [];
          List<String> idlist = [];
          list.forEach((element) {
            formsList.add(element["formid"]);
          });
          list.forEach((element) {
            namelist.add(element["name"]);
          });
          list.forEach((element) {
            idlist.add(element["userid"]);
          });
          return Scaffold(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            appBar: AppBar(
              elevation: 0.1,
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              title: Text("Grant Group OD option"),
            ),
            body: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        key: Key('student-field'),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        elevation: 8.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),

                          // color: Color.fromRGBO(64, 75, 96, .9),
                          child: FormBuilderDropdown(
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.white,
                            focusColor: Colors.white,
                            decoration: textInputDecoration,
                            style: TextStyle(color: Colors.white),
                            dropdownColor: Color.fromRGBO(64, 75, 96, .9),
                            validator: (val) {
                              return check_If_StudentID_isClicked(clickedstuid);
                            },
                            hint: Text(
                              studentdropname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            name: "student",
                            items: namelist.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  clickedstuid =
                                  idlist[namelist.indexOf(value)];
                                  studentdropname = value;
                                  clickedform =
                                  formsList[namelist.indexOf(value)];
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      Card(
                        key: Key('date-field'),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        elevation: 8.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: FormBuilderDateRangePicker(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              cursorColor: Colors.white,
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2030),
                              name: "dateform",
                              controller: datecont,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Date"),
                              validator: (val) {
                                return check_If_Date_isClicked(datecont.text);
                              }),
                        ),
                      ),
                      Card(
                        key: Key('limiter-field'),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        elevation: 8.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            cursorColor: Colors.white,
                            controller: numcont,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Limiter"),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          key: Key('submit-field'),
                          style: buttonStyle,
                          onPressed: () {
                            _formKey.currentState.save();
                            if (_formKey.currentState.validate()) {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(clickedform)
                                  .update({
                                "grantOD": true,
                                "timeGrantOD": datecont.text,
                                "limiter": numcont.text
                              });
                              final snackBar = SnackBar(
                                  content: Text(
                                      'The student has been given the permission.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Submit "))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    }
  }
}

check_If_StudentID_isClicked(dynamic clickedstuid) {
  if (clickedstuid != "" &&
      clickedstuid != null) {
    return null;
  } else {
    return "Please select a student";
  }
}

check_If_Date_isClicked(String date) {
  if (date != "" &&
      date != null) {
    return null;
  } else {
    return "Please enter the date/s";
  }
}