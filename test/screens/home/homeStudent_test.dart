import 'package:aumsodmll/screens/home/homeStudent.dart';
// import 'package:aumsodmll/screens/apply/odApply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:aumsodmll/mock.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aumsodmll/services/auth.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}
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

group("Student home page testing", (){

 testWidgets("Test for logout button" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));
  final logout = Key("logout-button");

  expect(find.byKey(logout),findsNothing);
  print("Found Logout button");
});
 testWidgets("Test for Apply OD tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));
  final applyOd = Key("apply-od");

  expect(find.byKey(applyOd),findsNothing);
  print("Found Apply OD tile");
});
 testWidgets("Test for Group OD tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));
  
  final gpod = Key("group-od");
 
  expect(find.byKey(gpod),findsNothing);
  print("Found group od tile");
  
});

 testWidgets("Test for Track Status tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));
 
  final status =Key("track-status");
  
  expect(find.byKey(status),findsNothing);
  print("Found Track Status tile");

});

 testWidgets("Test for Calendar tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));
  final calendar =Key("cal");

  expect(find.byKey(calendar),findsNothing);
  print("Found Calendar tile");

});
 testWidgets("Test for FAQs tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));

  final faqs = Key("faqs");

  expect(find.byKey(faqs),findsNothing);
  print("Found FAQs tile");
});
 testWidgets("Negative test- Find unnecessary componenet from faculty home" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));

  final approveOd = Key("approve-od");
  final grantgp = Key("grantgrp");
 

  expect(find.byKey(approveOd),findsOneWidget);
  print("Did not find Approve OD tile");
  expect(find.byKey(grantgp),findsOneWidget);
  print("Did not find Grant group od tile");
});

});

}