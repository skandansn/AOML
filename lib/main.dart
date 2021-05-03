import 'package:aumsodmll/faqPage.dart';
import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/screens/apply/applygrp.dart';
import 'package:aumsodmll/screens/apply/odApply.dart';
import 'package:aumsodmll/screens/apply/track.dart';
import 'package:aumsodmll/screens/approve/approve.dart';
import 'package:aumsodmll/screens/attendanceCalendar.dart';
import 'package:aumsodmll/screens/grantGrpOd.dart';
import 'package:aumsodmll/screens/login/forgot_password.dart';
import 'package:aumsodmll/helpers/wrapper.dart';
import 'package:aumsodmll/screens/pinnedFaqs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aumsodmll/services/auth.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        color: Colors.blueGrey[600],
        // theme:
        //     ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
        // themeMode: ThemeMode.light,
        // debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/forgotPass': (context) => ForgotPassword(),
          '/od': (context) => OD(),
          '/applygrp': (context) => ApplyGrp(),
          '/track': (context) => Track(),
          '/faq': (context) => Faq(),
          '/pinnedfaq': (context) => PinnedFaq(),
          '/approve': (context) => Approve(),
          '/grantgrpod': (context) => GrantGrpOD(),
          '/calendar': (context) => AttendanceCalendar(),
        },
        home: Wrapper(),
      ),
    );
  }
}
