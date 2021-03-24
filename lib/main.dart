import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/screens/apply/daypass.dart';
import 'package:aumsodmll/screens/apply/homepass.dart';
import 'package:aumsodmll/screens/apply/ml.dart';
import 'package:aumsodmll/screens/apply/od.dart';
import 'package:aumsodmll/screens/apply/track.dart';
import 'package:aumsodmll/screens/forgot_password.dart';
import 'package:aumsodmll/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aumsodmll/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/forgotPass': (context) => ForgotPassword(),
          '/daypass': (context) => Daypass(),
          '/homepass': (context) => Homepass(),
          '/od': (context) => OD(),
          '/ml': (context) => ML(),
          '/track':(context) => Track(),
        },
        home: Wrapper(),
      ),
    );
  }
}
