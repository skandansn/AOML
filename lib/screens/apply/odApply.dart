import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:mime_type/mime_type.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  // var advisordropname = "Select your advisor";
  // var facultydropname = "Select your faculty";
  var dropdowntype = "Select type";
  var hod;
  var clickedidad = "";
  var clickedidfac = "";
  var typesel = "";
  String addproofname = "Add proof";
  bool addedimage = false;
  File _imagefinal;
  dynamic filetype;
  Uint8List _uploadfile;
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
          // String fileName = basename(result.files.single.path);
          // print(fileName);
          _uploadfile = result.files.single.bytes;
          filetype = false;
          _finalfile = _uploadfile;
        }
      });
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();
  var types = ["OD", "ML", "Daypass", "Homepass"];
  @override
  Widget build(BuildContext context) {
    var arguements = ModalRoute.of(context).settings.arguments;
    if (arguements.toString() != "" && arguements != null) {
      datecont.text = arguements.toString();
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
              var list = snapshot.data;
              list.removeAt(0);
              var stuname = list[0];
              list.removeAt(0);
              var stuNo = list[0];
              list.removeAt(0);
              list.removeAt(0);
              list.removeAt(0);
              list.removeAt(0);
              var odLimiter = snapshot.data[0];
              snapshot.data.removeAt(0);
              var branch = snapshot.data[0];
              snapshot.data.removeAt(0);
              var adv = snapshot.data[0];
              snapshot.data.removeAt(0);

              if (odLimiter < 1) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  final snackBar = SnackBar(
                      content: Text(
                          'Sorry, You do have used all of your application forms.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                });
              }
              list.forEach((element) {
                if (element['hod'] == branch) {
                  hod = element['userid'];
                }
              });

              return Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                appBar: AppBar(
                  elevation: 0.1,
                  backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                  title: Text("Applying"),
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
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: FormBuilderTextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                name: "timeform",
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                                controller: timecont,
                                decoration: textInputDecoration.copyWith(
                                    labelText: "Time"),
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
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: FormBuilderTextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                name: "descform",
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                ]),
                                controller: descriptioncont,
                                decoration: textInputDecoration.copyWith(
                                    labelText: "Description"),
                              ),
                            ),
                          ),
                          Card(
                            key: Key('type-field'),
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            elevation: 8.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: FormBuilderDropdown(
                                focusColor: Colors.white,
                                decoration: textInputDecoration,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                dropdownColor: Color.fromRGBO(64, 75, 96, .9),
                                name: 'typeform',
                                hint: Text(
                                  dropdowntype,
                                  style: TextStyle(color: Colors.white),
                                ),
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
                                        child: Text(
                                          '$type',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          typesel = type;
                                          dropdowntype = type;
                                        }))
                                    .toList(),
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
                                      style: TextStyle(color: Colors.white),
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
                                                    child: Image.file(
                                                      File(_imagefinal.path),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )
                                                : Text(_imagefinal.path)
                                          ],
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
                                          key: Key('addproof-field'),
                                          style: buttonStyle,
                                          child: Text("Remove proof"),
                                          onPressed: () {
                                            setState(() {
                                              _imagefinal = null;
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
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              key: Key('submit-field'),
                              style: buttonStyle,
                              onPressed: () {
                                _formKey.currentState.save();
                                if (_formKey.currentState.validate()) {
                                  _db.applyod(
                                      userid,
                                      stuname,
                                      stuNo,
                                      adv,
                                      hod,
                                      datecont.text,
                                      timecont.text,
                                      descriptioncont.text,
                                      typesel,
                                      _finalfile);
                                  final snackBar = SnackBar(
                                      content: Text(
                                          'Application has been submitted.'));
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
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
