import 'package:aumsodmll/services/auth.dart';
import 'package:aumsodmll/shared/constants.dart';
import 'package:flutter/material.dart';

final AuthService _auth = AuthService();

Future<void> confirmLogoutBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Center(
              child: Text(
            'Confirm logout',
            style: TextStyle(color: Colors.white),
          )),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: buttonStyle,
                child: Text("Yes"),
                onPressed: () async {
                  final snackBar =
                      SnackBar(content: Text('Logged out succefully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                  await _auth.signOut();
                },
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: buttonStyle,
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}
