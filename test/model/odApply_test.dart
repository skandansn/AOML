// import 'package:aumsodmll/screens/apply/odApply.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
// //   Widget testWidget = new MediaQuery(
// //       data: new MediaQueryData(),
// //       child: new MaterialApp(home: new SignIn())
// // );
// Widget createWidgetForTesting({Widget child}){
// return MaterialApp(
//   home: child,
// );
// }
// group("OD Apply page testing", (){
//   testWidgets('Check for necessary components in the Apply OD page', (WidgetTester tester)async{
//      await tester.pumpWidget(createWidgetForTesting(child:new OD()));
//     //  await tester.pumpAndSettle();
//     //  Finder advisor = find.byKey(new Key('email-field'));
//     // Finder pwd = find.byKey(new Key('password-field'));
//      final advisor = Key('advisor-field');
//     final faculty = Key('faculty-field');
//     final date = Key('date-field');
//     final time = Key('time-field');
//     final desc = Key('description-field');
//     final typef = Key('type-field');
//     final addproof = Key('addproof-field');
//     final submit = Key('submit-field');
//     expect(find.byKey(advisor,skipOffstage: false),findsOneWidget);
//     // expect(find.byKey(ValueKey('advisor-field')), findsOneWidget);
//     print("Found advisor field");
//     // expect(find.byKey(faculty),findsOneWidget);
//     // print("Found faculty field");
//     // expect(find.byKey(date),findsOneWidget);
//     // print("Found date field");
//     // expect(find.byKey(time),findsOneWidget);
//     // print("Found time field");
//     // expect(find.byKey(desc),findsOneWidget);
//     // print("Found description field");
//     // expect(find.byKey(typef),findsOneWidget);
//     // print("Found type field");
//     // expect(find.byKey(addproof),findsOneWidget);
//     // print("Found add-proof button");
//     // expect(find.byKey(submit),findsOneWidget);
//     // print("Found submit button");
//   });

// });
// }