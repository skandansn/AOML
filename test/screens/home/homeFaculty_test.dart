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
 testWidgets("Test Scaffold" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  // final logout = Key("logout-button");
  final scaf = Key("scaf");
  // Finder findscaf = find.byKey(new Key('scaf'));
  expect(find.byKey(scaf),findsOneWidget);
  print("Found Scaffold in Home Faculty");
 
});

testWidgets("Test Padding" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  // final logout = Key("logout-button");
  final pad  = Key("Padding");

  expect(find.byKey(pad),findsOneWidget);
  print("Found Padding widget in Home Faculty");
});

testWidgets("Test Scrollbar" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  // final logout = Key("logout-button");
  final lst   = Key("list");

  expect(find.byKey(lst),findsOneWidget);
  print("Found Scrollbar widget in Home Faculty");
});
// testWidgets("Test List View" ,(WidgetTester tester)async{
//     final AuthService auth = AuthService();
//   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
//   // final logout = Key("logout-button");
//   final lstV   = Key("listView");

//   expect(find.byKey(lstV),findsOneWidget);
//   print("Found ListView widget in Home Faculty");
// });




// testWidgets("Test Card" ,(WidgetTester tester)async{
//     final AuthService auth = AuthService();
//   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
//   // final logout = Key("logout-button");
//   final car    = Key("card1");

//   expect(find.byKey(car),findsOneWidget);
//   print("Found ListView widget in Home Faculty");
// });

 testWidgets("Test for logout button" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  final logout = Key("logout-button");

  expect(find.byKey(logout),findsOneWidget);
  print("Found Logout button");
});

 testWidgets("Test for Approve OD tile" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
   final apod = Key("approve-od");
    // final approveOd = Key("approve-od");
    // final scroll = Key("list");
  // var textFind = find.text('Approve/deny application');
  // expect(textFind, findsOneWidget);
  // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
  //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
  // await tester.pumpAndSettle();
  expect(find.byKey(apod),findsOneWidget);
  print("Found Approve OD tile"); 
});
testWidgets("Test for Approve OD Container widget" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
   final apod = Key("apod-Container");
    // final approveOd = Key("approve-od");
    // final scroll = Key("list");
  // var textFind = find.text('Approve/deny application');
  // expect(textFind, findsOneWidget);
  // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
  //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
  // await tester.pumpAndSettle();
  expect(find.byKey(apod),findsOneWidget);
  print("Found Approve OD Container widget"); 
});

 testWidgets("Test for Approve OD tile Elevation" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  //  final apod = Key("approve-od");
    // final approveOd = Key("approve-od");
    // final scroll = Key("list");
  // var textFind = find.text('Approve/deny application');
  // expect(textFind, findsOneWidget);
  // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
  //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
  // await tester.pumpAndSettle();
  // expect(find.byKey(apod),findsOneWidget);
  // print("Found Approve OD tile");
  Finder findsapod = find.byKey(new Key('approve-od'));
  Card apodc = tester.firstWidget(findsapod);
  // Widget scaff = tester.firstWidget(findscaf);
  expect(apodc.elevation, 8.0);
  print("Elevation is 8.0");
  
});

testWidgets("Test for Approve OD tile Margins" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  //  final apod = Key("approve-od");
    // final approveOd = Key("approve-od");
    // final scroll = Key("list");
  // var textFind = find.text('Approve/deny application');
  // expect(textFind, findsOneWidget);
  // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
  //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
  // await tester.pumpAndSettle();
  // expect(find.byKey(apod),findsOneWidget);
  // print("Found Approve OD tile");
  Finder findsapod = find.byKey(new Key('approve-od'));
  Card apodc = tester.firstWidget(findsapod);
  // Widget scaff = tester.firstWidget(findscaf);
  expect(apodc.margin, EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0));
  print("margins are 10.0 and 6.0");
  
});
testWidgets("Test for Approve OD Container Text widget" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  //  final apod = Key("apod-text");
   Finder findsapod = find.byKey(new Key('apod-text'));
    // final approveOd = Key("approve-od");
    // final scroll = Key("list");
  // var textFind = find.text('Approve/deny application');
  // expect(textFind, findsOneWidget);
  // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
  //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
  // await tester.pumpAndSettle();
  // expect(find.byKey(apod),findsOneWidget);
  Text apodtext = tester.firstWidget(findsapod);
  expect(apodtext.style.color,Colors.white);
  print("Text is in white colour"); 
});
testWidgets("Test for Approve OD Container Text widget" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  //  final apod = Key("apod-text");
   Finder findsapod = find.byKey(new Key('apod-text'));
    // final approveOd = Key("approve-od");
    // final scroll = Key("list");
  // var textFind = find.text('Approve/deny application');
  // expect(textFind, findsOneWidget);
  // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
  //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
  // await tester.pumpAndSettle();
  // expect(find.byKey(apod),findsOneWidget);
  Text apodtext = tester.firstWidget(findsapod);
  expect(apodtext.style.fontWeight,FontWeight.bold);
  print("Text font is bold"); 
});
// testWidgets("Test for Approve OD Container decoration widget" ,(WidgetTester tester)async{
//    await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
//   //  final apod = Key("apod-text");
//    Finder findsapod = find.byKey(new Key('apod-Container'));
//     // final approveOd = Key("approve-od");
//     // final scroll = Key("list");
//   // var textFind = find.text('Approve/deny application');
//   // expect(textFind, findsOneWidget);
//   // find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd));
//   //  expect(find.descendant(of: find.byKey(Key("list")), matching: find.byKey(approveOd)),findsOneWidget);
//   // await tester.pumpAndSettle();
//   // expect(find.byKey(apod),findsOneWidget);
//   Container apodcont = tester.firstWidget(findsapod);
//   expect(apodcont.decoration, findsOneWidget);
//   print("Found decorations done for container widget"); 
// });




 testWidgets("Test for Grant Group OD Permission tile" ,(WidgetTester tester)async{
   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  final grantgp = Key("grantgrp");
 
  expect(find.byKey(grantgp),findsOneWidget);
  print("Found Grant group od tile");
  
});
testWidgets("Test for FAQs tile" ,(WidgetTester tester)async{
    final AuthService auth = AuthService();
  await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));

  final faqs = Key("faq");
  // await tester.pumpAndSettle();
  expect(find.byKey(faqs),findsOneWidget);
  print("Found FAQs tile");
});

  // testWidgets("Forgot password- email sent message test", (WidgetTester tester)async{
  //   await tester.pumpWidget(createWidgetForTesting(child:new HomeFaculty("Faculty A")));
  //   final logout = Key('logout-button');
  //   // await tester.enterText(forgotemail, 'shakthiboy@gmail.com');
  //   // await tester.pump();
  //   // Finder formWidgetFinder = find.byType(Form);
  //   // Form formWidget = tester.widget(formWidgetFinder) as Form;
  //   // GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
  //   // expect(formKey.currentState.validate(), isTrue);
  //   // // var button = find.byKey(new Key("sendemail-button"));
  //   // final emailsend = Key('sendemail-button');
  //   final msg = Key("text-message");
  //   expect(find.byKey(logout),findsOneWidget);
  //   await tester.tap(find.byKey(emailsend));
  //   await tester.pumpAndSettle();
  //   expect(find.byKey(msg),findsOneWidget);
  // });
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