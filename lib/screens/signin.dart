import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:aumsodmll/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = "";
  String pass = "";
  final DatabaseService _db = DatabaseService();

  final _formkey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: Text("Sign in to AOML"),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Image.network('https://i.imgur.com/pBHz39v.jpg'),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Email"),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your username' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) =>
                            val.length < 6 ? 'Enter your password' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            pass = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .sinInWithEmailAndPassword(email, pass);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      "SignIn failed! Verify your credentials and try again";
                                });
                              }
                            }
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      OutlineButton(
                        child: Text("Forgot password?"),
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgotPass");
                        },
                      )
                    ],
                  ),
                )),
          );
  }
}
