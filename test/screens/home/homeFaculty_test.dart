import 'package:aumsodmll/screens/home/homeFaculty.dart';
import 'package:aumsodmll/screens/apply/odApply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:aumsodmll/mock.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aumsodmll/services/auth.dart';

void main() {
//   Widget testWidget = new MediaQuery(
//       data: new MediaQueryData(),
//       child: new MaterialApp(home: new SignIn())
// );
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
Widget createWidgetForTesting({Widget child}){
return MaterialApp(
  home: child,
);
}

group("Faculty home page testing", (){

 testWidgets("Test for logout button" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  final logout = Key("logout-button");

  expect(find.byKey(logout),findsOneWidget);
  print("Found Logout button");
});
 testWidgets("Test for Approve OD tile" ,(WidgetTester tester)async{
    final approveOd = Key("approve-od");
 

  expect(find.byKey(approveOd),findsNothing);
  print("Found Approve OD tile");
  
});
 testWidgets("Test for Grant Group OD Permission tile" ,(WidgetTester tester)async{
  final grantgp = Key("grantgrp");
 
  expect(find.byKey(grantgp),findsNothing);
  print("Found Grant group od tile");
  
});
testWidgets("Test for FAQs tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));

  final faqs = Key("faqs");

  expect(find.byKey(faqs),findsNothing);
  print("Found FAQs tile");
});
  testWidgets("Negative test- Find unnecessary componenet from Student home" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));

 final applyOd = Key("apply-od");

  expect(find.byKey(applyOd),findsOneWidget);
  print("Did not find Apply OD tile");

  final gpod = Key("group-od");
 
  expect(find.byKey(gpod),findsOneWidget);
  print("Did not find group od tile");

  final status =Key("track-status");
  
  expect(find.byKey(status),findsOneWidget);
  print("Did not find Track Status tile");

  final calendar =Key("cal");

  expect(find.byKey(calendar),findsOneWidget);
  print("Did not find Calendar tile");


});

});

}