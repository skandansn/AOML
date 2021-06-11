import 'package:aumsodmll/faqPage.dart';
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

group("FAQ page testing", (){

   testWidgets("Test for Pinned-Faq Icon" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new Faq()));
  final pinned  = Key("pinned");

  expect(find.byKey(pinned),findsNothing);
  print("Found Pinned-Faq Icon");
});

 testWidgets("Test for Sort-by Icon" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new Faq()));
  final pinned  = Key("pinned");
  final sort  = Key("sort-button");

  expect(find.byKey(pinned),findsNothing);
  print("Found Sort-by Icon");
});

testWidgets("Test for Add floating action button" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new Faq()));
  final add  = Key("add-button");

  expect(find.byKey(add),findsNothing);
  print("Found add floating action button");
});



});

}