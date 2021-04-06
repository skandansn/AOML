import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
//   Widget testWidget = new MediaQuery(
//       data: new MediaQueryData(),
//       child: new MaterialApp(home: new SignIn())
// );
Widget createWidgetForTesting({Widget child}){
return MaterialApp(
  home: child,
);
}}