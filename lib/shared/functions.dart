import 'package:aumsodmll/services/auth.dart';
import 'package:flutter/material.dart';

final AuthService _auth = AuthService();

Future<void> confirmLogoutBox(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm logout'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Yes"),
                onPressed: () async {
                  Navigator.pop(context);
                  await _auth.signOut();
                },
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
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
