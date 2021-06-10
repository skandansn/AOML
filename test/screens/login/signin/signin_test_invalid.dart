import 'package:aumsodmll/screens/login/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aumsodmll/mock.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aumsodmll/services/auth.dart';
// import 'package:image_test_utils/image_test_utils.dart';

void main() {
  
    // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  Widget createWidgetForTesting({Widget child}){
return MaterialApp(
  home: child,
);
}
testWidgets("SignIn with invalid email and password",(WidgetTester tester)async{
    await tester.pumpWidget(createWidgetForTesting(child:new SignIn()));
    // Finder img = find.byKey(new Key("image-field"));
    Finder email = find.byKey(new Key('email-field'));
    Finder pwd = find.byKey(new Key('password-field'));
    // provideMockedNetworkImages(()async{
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Image.network("'https://i.imgur.com/pQR0s45.jpg'")
    //     )
    //   );
    // });
    await tester.enterText(email, 'shakthi');
    await tester.enterText(pwd, 'aaaaaa');
    await tester.pump();
    print("This is a negative test - The test should fail");
    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    print("Signin with invalid email password should not pass and the test should fail.");
    expect(formKey.currentState.validate(), isTrue);
  });
}