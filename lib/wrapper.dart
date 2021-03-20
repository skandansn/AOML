import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/screens/authenticate.dart';
import 'package:aumsodmll/screens/homeFaculty.dart';
import 'package:aumsodmll/screens/homeStudent.dart';
import 'package:aumsodmll/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final DatabaseService _db = DatabaseService();

  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final type = await _db.fun();
    // print(type);
    if (user == null) {
      return Authenticate();
    }
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            if (data == true) {
              return HomeStudent();
            } else {
              return HomeFaculty();
            }
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
      future: _db.fun(),
    );
  }
}
