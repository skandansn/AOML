import 'package:aumsodmll/screens/login/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:image_test_utils/image_test_utils.dart';

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
group("Password Reset Page Testing", (){
  testWidgets("Check for necessary components in the forgot password page", (WidgetTester tester)async{
    // provideMockedNetworkImages(()async{
    //   await tester.pumpWidget(createWidgetForTesting(child:new ForgotPassword()));
    // });
    await tester.pumpWidget(createWidgetForTesting(child:new ForgotPassword()));
    final forgotemail = Key('forgotemail-field');
    final emailsend = Key('sendemail-button');

    expect(find.byKey(forgotemail),findsOneWidget);
    print("Found forgotmail field");
    expect(find.byKey(emailsend),findsOneWidget);
    print("Found send mail button");

  });
  testWidgets("Forgot password email validation",(WidgetTester tester)async{
    await tester.pumpWidget(createWidgetForTesting(child:new ForgotPassword()));
    Finder forgotemail = find.byKey(new Key('forgotemail-field'));
    // Finder emailsend = find.byKey(new Key('sendemail-button'));
    // final forgotemail = Key('forgotemail-field');
    // final emailsend = Key('sendemail-button');
    await tester.enterText(forgotemail, 'shakthiboy@gmail.com');
    // await tester.enterText(pwd, 'aaaaaa');
    await tester.pump();

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    print("Valid email test passed");
    expect(formKey.currentState.validate(), isTrue);
  });

  testWidgets("Forgot password- email sent message test", (WidgetTester tester)async{
    await tester.pumpWidget(createWidgetForTesting(child:new ForgotPassword()));
    Finder forgotemail = find.byKey(new Key('forgotemail-field'));
    await tester.enterText(forgotemail, 'shakthiboy@gmail.com');
    await tester.pump();
    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    expect(formKey.currentState.validate(), isTrue);
    // var button = find.byKey(new Key("sendemail-button"));
    final emailsend = Key('sendemail-button');
    final msg = Key("text-message");
    expect(find.byKey(emailsend),findsOneWidget);
    await tester.tap(find.byKey(emailsend));
    await tester.pumpAndSettle();
    expect(find.byKey(msg),findsOneWidget);
  });

});
}

