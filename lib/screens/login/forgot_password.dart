import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_gifs/loading_gifs.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String msg = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    TextEditingController emailcontr = new TextEditingController();
    final _formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        elevation: 0.1,
        title: Text("Forgot password"),
      ),
      backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              children: [
                FadeInImage.assetNetwork(
                    placeholder: cupertinoActivityIndicatorSmall,
                    image: 'https://i.imgur.com/pQR0s45.jpg'),
                SizedBox(height: 20),
                Card(
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  elevation: 8.0,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: FormBuilderTextField(
                        key:Key('forgotemail-field'),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                        name: "forgotemail",
                        controller: emailcontr,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          hoverColor: Color.fromRGBO(64, 75, 96, .9),
                          fillColor: Color.fromRGBO(64, 75, 96, .9),
                          focusColor: Color.fromRGBO(64, 75, 96, .9),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  key:Key("sendemail-button"),
                  style: buttonStyle,
                  child: Text('Send Email'),
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      String result =
                          await _auth.resetPassword(emailcontr.text);
                      setState(() {
                        if (result == "") {
                          msg = "Email has been sent. ";
                        } else {
                          msg = result;
                        }
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(msg),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.blueGrey[600])),
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
