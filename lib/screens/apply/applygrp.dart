import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mime_type/mime_type.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ApplyGrp extends StatefulWidget {
  @override
  _ApplyGrpState createState() => _ApplyGrpState();
}

class _ApplyGrpState extends State<ApplyGrp> {
  DatabaseService _db = DatabaseService();
  TextEditingController datecont = new TextEditingController();
  TextEditingController timecont = new TextEditingController();
  TextEditingController descriptioncont = new TextEditingController();
  // var advisordropname = "Select your advisor";
  var facultydropname = "Select your faculty";
  var studentdrop = "Select the student";
  var clickedstu = "";
  List<MultiSelectItem> _items;

  // var headdropname = "Select your HOD";
  // var clickedidad = "";
  var clickedidfac = "";
  // var clickedidhead = "";
  String addproofname = "Add proof";
  bool addedimage = false;
  File _imagefinal;
  dynamic filetype;
  dynamic _uploadfile;
  dynamic _finalfile;
  Future<void> getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    // File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        addproofname = "Change proof";
        addedimage = true;
        try {
          _imagefinal = File(result.files.single.path);
          filetype = mime(_imagefinal.path);
          if (filetype.contains("image")) {
            filetype = true;
          } else {
            filetype = false;
          }
          _finalfile = _imagefinal;
        } catch (e) {
          _uploadfile = result.files.single.bytes;
          filetype = false;
          _finalfile = _uploadfile;
        }
      });
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();

  var selectedStudents;
  var selectedStudentsIds = [];
  @override
  Widget build(BuildContext context) {
    var FacultyList;
    var StudentList;
    var StudentNameList = [];
    void _showMultiSelect(BuildContext context) async {
      await showModalBottomSheet(
        isScrollControlled: true, // required for min/max child size
        context: context,
        builder: (ctx) {
          return MultiSelectBottomSheet(
            items: _items,
            searchable: true,
            title: Text("Student List"),
            onConfirm: (values) {
              setState(() {
                selectedStudents = values;
              });
            },
            maxChildSize: 0.8,
            initialValue: [],
          );
        },
      );
    }

    return FutureBuilder<List>(
      future: _db.getUsersList(false), // async work
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              var userid = "${snapshot.data.first}";
              FacultyList = snapshot.data;
              FacultyList.removeAt(0);
              FacultyList.removeAt(0);
              FacultyList.removeAt(0);
              FacultyList.removeAt(0);
              FacultyList.removeAt(0);
              FacultyList.removeAt(0);

              // var odLimiter = snapshot.data[0];
              // snapshot.data.removeAt(0);
              // var branch = snapshot.data[0];
              // snapshot.data.removeAt(0);
              // var adv = snapshot.data[0];
              // snapshot.data.removeAt(0);

              // list.forEach((element) {
              //   if (element['hod'] == branch) {
              //     hod = element['userid'];
              //   }
              // });

              return FutureBuilder<List>(
                  future: _db.getUsersList(true), // async work
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Loading();
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else {
                          var userid = "${snapshot.data.first}";
                          StudentList = snapshot.data;
                          List<String> formsList = [];
                          StudentList.removeAt(0);
                          var stuname = StudentList[0];
                          StudentList.removeAt(0);
                          var stuNo = StudentList[0];
                          StudentList.removeAt(0);
                          var grantPermission = StudentList[0];
                          StudentList.removeAt(0);
                          var grantPermissionTime = StudentList[0];
                          StudentList.removeAt(0);
                          StudentList.removeAt(0);
                          int odLimiter = (StudentList[0]);
                          StudentList.removeAt(0);
                          StudentList.removeAt(0);
                          StudentList.removeAt(0);
                          // print(FacultyList);

                          // print(StudentList);
                          if (odLimiter < 1) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Sorry, You do have used all of your application forms.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            });
                          }
                          var st, end;
                          if (grantPermissionTime != "" &&
                              grantPermissionTime != null) {
                            DateFormat format = DateFormat("MM/dd/yyyy");
                            st = (grantPermissionTime.split(" - ")[0]);
                            end = (grantPermissionTime.split(" - ")[1]);

                            st = (format.parse(st));
                            end = (format.parse(end));
                          } else {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Sorry, You do not have the permission to apply group ODs'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            });
                          }
                          if (end != null) {
                            if (DateTime.now().isAfter(end)) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Sorry, You do not have the permission to apply group ODs'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              });
                            }
                          }
                          if (grantPermission == true) {
                            FacultyList.removeAt(0);

                            FacultyList.removeAt(0);
                            FacultyList.removeAt(0);

                            StudentList.forEach((element) {
                              StudentNameList.add(element["stuNo"]);
                            });
                            _items = StudentNameList.map(
                                (item) => MultiSelectItem(item, item)).toList();
                            List<String> facultyNameList = [];

                            FacultyList.forEach((element) {
                              facultyNameList.add(element["name"]);
                            });

                            return Scaffold(
                              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                              appBar: AppBar(
                                elevation: 0.1,
                                backgroundColor:
                                    Color.fromRGBO(58, 66, 86, 1.0),
                                title: Text("Applying GroupOD"),
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
                                          key: Key('students-field'),
                                          margin: new EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          elevation: 8.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    64, 75, 96, .9)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            child: ElevatedButton(
                                              style: buttonStyle,
                                              onPressed: () {
                                                _showMultiSelect(context);
                                              },
                                              child:
                                                  Text("Select the students"),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          margin: new EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          elevation: 8.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    64, 75, 96, .9)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            child: FormBuilderDropdown(
                                              iconEnabledColor: Colors.white,
                                              iconDisabledColor: Colors.white,
                                              focusColor: Colors.white,
                                              decoration: textInputDecoration,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              dropdownColor: Color.fromRGBO(
                                                  64, 75, 96, .9),
                                              hint: Text(
                                                facultydropname,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              name: "faculty",
                                              key: Key('faculty-field'),
                                              validator: (val) {
                                                if (clickedidfac != "" &&
                                                    clickedidfac != null) {
                                                  return null;
                                                } else {
                                                  return "Please select a faculty";
                                                }
                                              },
                                              items: facultyNameList
                                                  .map((String value) {
                                                return new DropdownMenuItem<
                                                    String>(
                                                  value: value,
                                                  child: new Text(
                                                    value,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onTap: () {
                                                    FacultyList.forEach(
                                                        (element) {
                                                      if (element["name"] ==
                                                          value) {
                                                        clickedidfac =
                                                            element["userid"];
                                                        facultydropname =
                                                            element['name'];
                                                      }
                                                    }); // clickedidfac = idlist[
                                                    //     namelist
                                                    //         .indexOf(value)];
                                                    // facultydropname = value;
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
                                                color: Color.fromRGBO(
                                                    64, 75, 96, .9)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            child: FormBuilderDateRangePicker(
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                cursorColor: Colors.white,
                                                firstDate: DateTime(1970),
                                                lastDate: DateTime(2030),
                                                name: "dateform",
                                                controller: datecont,
                                                decoration: textInputDecoration
                                                    .copyWith(hintText: "Date"),
                                                validator: (val) {
                                                  if (datecont.text != "" &&
                                                      datecont.text != null) {
                                                    return null;
                                                  } else {
                                                    return "Please enter the date/s";
                                                  }
                                                }),
                                          ),
                                        ),
                                        Card(
                                          key: Key('time-field'),
                                          margin: new EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          elevation: 8.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    64, 75, 96, .9)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            child: FormBuilderTextField(
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              name: "timeform",
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                    context),
                                              ]),
                                              controller: timecont,
                                              decoration: textInputDecoration
                                                  .copyWith(labelText: "Time"),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          key: Key('decription-field'),
                                          margin: new EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          elevation: 8.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    64, 75, 96, .9)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                            child: FormBuilderTextField(
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              name: "descform",
                                              validator: FormBuilderValidators
                                                  .compose([
                                                FormBuilderValidators.required(
                                                    context),
                                              ]),
                                              controller: descriptioncont,
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                      labelText: "Description"),
                                            ),
                                          ),
                                        ),
                                        addedimage
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Attached proof",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  if (_imagefinal != null)
                                                    SizedBox(
                                                      height: 150,
                                                      width: 150,
                                                      child: Column(
                                                        children: [
                                                          filetype
                                                              ? Expanded(
                                                                  child: Image
                                                                      .file(
                                                                    File(_imagefinal
                                                                        .path),
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                )
                                                              : Text(_imagefinal
                                                                  .path)
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              )
                                            : Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                style: buttonStyle,
                                                onPressed: () {
                                                  getImage();
                                                },
                                                child: Text(addproofname)),
                                            addedimage
                                                ? Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      ElevatedButton(
                                                        key: Key(
                                                            'addproof-field'),
                                                        style: buttonStyle,
                                                        child: Text(
                                                            "Remove proof"),
                                                        onPressed: () {
                                                          setState(() {
                                                            _imagefinal = null;
                                                            addproofname =
                                                                "Add proof";
                                                            addedimage = false;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        ElevatedButton(
                                            key: Key('submit-field'),
                                            style: buttonStyle,
                                            onPressed: () {
                                              _formKey.currentState.save();

                                              if (_formKey.currentState
                                                  .validate()) {
                                                selectedStudents
                                                    .forEach((element) {
                                                  StudentList.forEach(
                                                      (element2) {
                                                    if (element ==
                                                        element2['stuNo']) {
                                                      selectedStudentsIds
                                                          .add(element2);
                                                    }
                                                  });
                                                });

                                                selectedStudentsIds =
                                                    selectedStudentsIds
                                                        .toSet()
                                                        .toList();
                                                // _db.applyGrpOd(selectedStudentsIds, fac, date, time, description, proof)
                                                final snackBar = SnackBar(
                                                    content: Text(
                                                        'Group OD application has been submitted.'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                _db.applyGrpOd(
                                                    selectedStudentsIds,
                                                    clickedidfac,
                                                    datecont.text,
                                                    timecont.text,
                                                    descriptioncont.text,
                                                    _imagefinal);
                                                Navigator.pop(context);
                                              } else {
                                                print("val failed");
                                              }
                                            },
                                            child: Text("Submit "))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }
                    }
                  });
            }
        }
      },
    );
  }
}
