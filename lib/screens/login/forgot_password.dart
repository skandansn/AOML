import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text("Forgot password"),
      ),
      // backgroundColor: Colors.grey[200],
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            children: [
              FadeInImage.assetNetwork(
                  placeholder: cupertinoActivityIndicatorSmall,
                  image: 'https://i.imgur.com/pQR0s45.jpg'),
              SizedBox(height: 20),
              TextFormField(
                  controller: emailcontr,
                  style: TextStyle(color: Colors.lightBlueAccent),
                  decoration: textInputDecoration.copyWith(hintText: "Email")),
              SizedBox(height: 20),
              ElevatedButton(
                style: buttonStyle,
                child: Text('Send Email'),
                onPressed: () async {
                  String result = await _auth.resetPassword(emailcontr.text);
                  setState(() {
                    if (result == "") {
                      msg = "Email has been sent. ";
                    } else {
                      msg = "Please enter a valid email address";
                    }
                  });
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
    );
  }
}
