import 'dart:io';

import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

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
  var clickedidad = "";
  var clickedidfac = "";
  var typesel = "";
  String addproofname = "Add proof";
  bool addedimage = false;
  File _imagefinal;
  Future<void> getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        addproofname = "Change proof";
        addedimage = true;
        _imagefinal = image;
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
                body: FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      FormBuilderDropdown(
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        hint: Text(advisordropname),
                        name: "advisor",
                        allowClear: true,
                        items: namelist.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              clickedidad = idlist[namelist.indexOf(value)];

                              // setState(() {
                              //   clickedidad = idlist[namelist.indexOf(value)];
                              //   advisordropname = value;
                              // });
                            },
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      FormBuilderDropdown(
                        hint: Text(facultydropname),
                        name: "faculty",
                        allowClear: true,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: namelist.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              // setState(() {
                              clickedidfac = idlist[namelist.indexOf(value)];
                              //   facultydropname = value;
                              // });
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
                      //           clickedidfac = idlist[namelist.indexOf(value)];
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
                        decoration:
                            textInputDecoration.copyWith(hintText: "Date"),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                      ),
                      // TextFormField(
                      //   controller: datecont,
                      //   decoration:
                      //       textInputDecoration.copyWith(hintText: "Date"),
                      // ),
                      FormBuilderTextField(
                        name: "timeform",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                        controller: timecont,
                        decoration:
                            textInputDecoration.copyWith(hintText: "Time"),
                      ),
                      FormBuilderTextField(
                        name: "descform",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                        controller: descriptioncont,
                        decoration: textInputDecoration.copyWith(
                            hintText: "Description"),
                      ),
                      FormBuilderDropdown(
                        name: 'typeform',
                        allowClear: true,
                        hint: Text('Select Type'),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        items: types
                            .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text('$type'),
                                onTap: () {
                                  typesel = type;
                                }))
                            .toList(),
                        // controller: typecont,
                        // decoration:
                        //     textInputDecoration.copyWith(hintText: "Type"),
                      ),
                      addedimage
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Attached image"),
                                SizedBox(
                                  height: 20,
                                ),
                                if (_imagefinal != null)
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.file(
                                      File(_imagefinal.path),
                                      fit: BoxFit.cover,
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
                                  content:
                                      Text('Application has been submitted.'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            } else {
                              print("validation failed");
                            }
                          },
                          child: Text("Submit "))
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
