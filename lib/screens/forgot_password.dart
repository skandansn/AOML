import 'package:aumsodmll/services/auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  String msg = "";
  String email = "";

  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final emailcontr = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Forgot password"),
      ),
      backgroundColor: Colors.grey[200],
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            children: [
              Image.network('https://i.imgur.com/pBHz39v.jpg'),
              SizedBox(height: 20),
              Text(
                'Enter Your Email',
                style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent),
              ),
              TextFormField(
                controller: emailcontr,
                style: TextStyle(color: Colors.lightBlueAccent),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.mail,
                    color: Colors.lightBlueAccent,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Send Email'),
                onPressed: () async {
                  String result = await _auth.resetPassword(emailcontr.text);
                  setState(() {
                    if (result == "") {
                      msg = "Email has been sent. ";
                    } else {
                      msg = result;
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              Text(msg),
              FlatButton(
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
