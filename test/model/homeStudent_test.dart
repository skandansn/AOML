import 'package:aumsodmll/screens/home/homeStudent.dart';
import 'package:aumsodmll/screens/apply/odApply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
void main() {
//   Widget testWidget = new MediaQuery(
//       data: new MediaQueryData(),
//       child: new MaterialApp(home: new SignIn())
// );
Widget createWidgetForTesting({Widget child}){
return MaterialApp(
  home: child,
);
}
group("Student home page testing", (){
  testWidgets("Test for necessary OD page components" ,(WidgetTester tester)async{
  await tester.pumpWidget(createWidgetForTesting(child:new HomeStudent("Shakthi Saravanan S")));
  final logout = Key("logout-button");
  final applyOd = Key("apply-od");
  final status =Key("track-status");
  final gpod = Key("group-od");
  expect(find.byKey(logout),findsOneWidget);
  print("Found Logout button");
  expect(find.byKey(applyOd),findsOneWidget);
  print("Found Apply OD button");
  expect(find.byKey(gpod),findsOneWidget);
  print("Found group od button");
  expect(find.byKey(status),findsOneWidget);
  print("Found Track Status button");
});
  testWidgets("Test Navigation to OD", (WidgetTester tester)async{
    final mockObserver =MockNavigatorObserver();
    await tester.pumpWidget(
      MaterialApp(
        home: HomeStudent("Shakthi Saravanan S"),
        navigatorObservers: [mockObserver],
      ),
    );
    final applyOd = Key("apply-od");
    expect(find.byKey(applyOd),findsOneWidget);
    await tester.tap(find.byKey(applyOd));
    await tester.pumpAndSettle();
    verify(mockObserver.didPush(any,any));
    expect(find.byType(OD), findsOneWidget);

  });

});

}