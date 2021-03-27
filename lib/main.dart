import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/route_generator.dart';
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
import 'package:flutter/services.dart';

// void main() {
//   runApp(MyApp());
// }
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/forgotPass': (context) => ForgotPassword(),
          '/daypass': (context) => Daypass(),
          '/homepass': (context) => Homepass(),
          '/od': (context) => OD(),
          '/ml': (context) => ML(),
          '/track': (context) => Track(),
        },
        home: SafeArea(child: Wrapper()),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
