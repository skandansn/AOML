import 'package:aumsodmll/services/database.dart';
import 'package:flutter/material.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/models/od.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class UpdateForm extends StatefulWidget {
  final dynamic od;
  UpdateForm({Key key, @required this.od}) : super(key: key);
  @override
  _UpdateFormState createState() => new _UpdateFormState(od: od);
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _currentDate = new TextEditingController();
  TextEditingController _currentTime = new TextEditingController();
  TextEditingController _currentDescription = new TextEditingController();
  OD od;
  _UpdateFormState({this.od});
  DatabaseService _db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userx>(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Text(
            'Update your OD/ML/Leave Form.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          Card(
            key: Key('date-field'),
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            elevation: 8.0,
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: FormBuilderDateRangePicker(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  cursorColor: Colors.white,
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2030),
                  name: "dateform",
                  controller: _currentDate,
                  decoration:
                      textInputDecoration.copyWith(hintText: "${od.date}"),
                  validator: (val) {
                    if (_currentDate.text != "" && _currentDate.text != null) {
                      return null;
                    } else {
                      return "Please enter the date/s";
                    }
                  }),
            ),
          ),
          SizedBox(height: 20.0),
          Card(
            key: Key('time-field'),
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            elevation: 8.0,
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: FormBuilderTextField(
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                name: "timeform",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                controller: _currentTime,
                decoration:
                    textInputDecoration.copyWith(labelText: "${od.time}"),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Card(
            key: Key('decription-field'),
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            elevation: 8.0,
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: FormBuilderTextField(
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                name: "descform",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                controller: _currentDescription,
                decoration: textInputDecoration.copyWith(
                    labelText: "${od.description}"),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
              key: Key('submit-field'),
              style: buttonStyle,
              onPressed: () async {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  _db.updateUserData(od, _currentDate.text, _currentTime.text,
                      _currentDescription.text);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Text("Update ")),
        ],
      ),
    );
  }
}
