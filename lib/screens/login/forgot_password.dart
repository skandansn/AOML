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
        backgroundColor: Colors.blueGrey[600],
        title: Text("Forgot password"),
      ),
      // backgroundColor: Colors.grey[200],
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
                FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    name: "forgotemail",
                    controller: emailcontr,
                    style: TextStyle(color: Colors.lightBlueAccent),
                    decoration:
                        textInputDecoration.copyWith(labelText: "Email")),
                SizedBox(height: 20),
                ElevatedButton(
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
                  child: Text("Sign in"),
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
