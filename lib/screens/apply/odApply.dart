import 'dart:io';

import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class OD extends StatefulWidget {
  @override
  _ODState createState() => _ODState();
}

class _ODState extends State<OD> {
  DatabaseService _db = DatabaseService();
  TextEditingController datecont = new TextEditingController();
  TextEditingController timecont = new TextEditingController();
  TextEditingController descriptioncont = new TextEditingController();
  var advisordropname = "Select your advisor";
  var facultydropname = "Select your faculty";
  var dropdowntype = "Select type";

  var clickedidad = "";
  var clickedidfac = "";
  var typesel = "";
  String addproofname = "Add proof";
  bool addedimage = false;
  File _imagefinal;
  Future<void> getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    // File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        addproofname = "Change proof";
        addedimage = true;
        _imagefinal = File(result.files.single.path);
      });
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();
  var types = ["OD", "ML", "Daypass", "Homepass"];
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
                  backgroundColor: Colors.blueGrey[600],
                  title: Text("Applying"),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          FormBuilderDropdown(
                            validator: (val) {
                              if (clickedidad != "" && clickedidad != null) {
                                return null;
                              } else {
                                return "Please select a advisor";
                              }
                            },
                            hint: Text(advisordropname),
                            name: "advisor",
                            items: namelist.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  clickedidad = idlist[namelist.indexOf(value)];
                                  advisordropname = value;
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          FormBuilderDropdown(
                            hint: Text(facultydropname),
                            name: "faculty",
                            validator: (val) {
                              if (clickedidfac != "" && clickedidfac != null) {
                                return null;
                              } else {
                                return "Please select a faculty";
                              }
                            },
                            items: namelist.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  clickedidfac =
                                      idlist[namelist.indexOf(value)];
                                  facultydropname = value;
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                          // DropdownButton<String>(
                          //   hint: Text(advisordropname),
                          //   items: namelist.map((String value) {
                          //     return new DropdownMenuItem<String>(
                          //       value: value,
                          //       child: new Text(value),
                          //       onTap: () {
                          //         setState(() {
                          //           clickedidad = idlist[namelist.indexOf(value)];
                          //           advisordropname = value;
                          //         });
                          //       },
                          //     );
                          //   }).toList(),
                          //   onChanged: (_) {},
                          // ),
                          // DropdownButton<String>(
                          //   hint: Text(facultydropname),
                          //   items: namelist.map((String value) {
                          //     return new DropdownMenuItem<String>(
                          //       value: value,
                          //       child: new Text(value),
                          //       onTap: () {
                          //         setState(() {
                          //           clickedidfac =
                          //               idlist[namelist.indexOf(value)];
                          //           facultydropname = value;
                          //         });
                          //       },
                          //     );
                          //   }).toList(),
                          //   onChanged: (_) {},
                          // ),
                          FormBuilderDateRangePicker(
                              firstDate: DateTime(1970),
                              lastDate: DateTime(2030),
                              name: "dateform",
                              controller: datecont,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Date"),
                              validator: (val) {
                                if (datecont.text != "" &&
                                    datecont.text != null) {
                                  return null;
                                } else {
                                  return "Please enter the date/s";
                                }
                              }),

                          FormBuilderTextField(
                            name: "timeform",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            controller: timecont,
                            decoration:
                                textInputDecoration.copyWith(labelText: "Time"),
                          ),
                          FormBuilderTextField(
                            name: "descform",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            controller: descriptioncont,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Description"),
                          ),

                          FormBuilderDropdown(
                            name: 'typeform',
                            hint: Text(dropdowntype),
                            validator: (val) {
                              if (typesel != "" && typesel != null) {
                                return null;
                              } else {
                                return "Please select a type";
                              }
                            },
                            items: types
                                .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text('$type'),
                                    onTap: () {
                                      typesel = type;
                                      dropdowntype = type;
                                    }))
                                .toList(),
                          ),
                          addedimage
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Attached proof"),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    if (_imagefinal != null)
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.file(
                                          File(_imagefinal.path),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                  ],
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                          style: buttonStyle,
                                          child: Text("Remove proof"),
                                          onPressed: () {
                                            setState(() {
                                              addproofname = "Add proof";
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
                              style: buttonStyle,
                              onPressed: () {
                                _formKey.currentState.save();
                                if (_formKey.currentState.validate()) {
                                  _db.applyod(
                                      userid,
                                      stuname,
                                      stuNo,
                                      clickedidfac,
                                      clickedidad,
                                      datecont.text,
                                      timecont.text,
                                      descriptioncont.text,
                                      typesel,
                                      _imagefinal);
                                  final snackBar = SnackBar(
                                      content: Text(
                                          'Application has been submitted.'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                } else {
                                  print(clickedidad);
                                  print(clickedidfac);
                                  print(typesel);
                                  print(datecont);

                                  print("validation failed");
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
      },
    );
  }
}
