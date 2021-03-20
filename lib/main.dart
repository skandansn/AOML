import 'package:aumsodmll/models/user.dart';
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
        },
        home: Wrapper(),
      ),
    );
  }
}
