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
 testWidgets("SignIn with email and password-Faculty",(WidgetTester tester)async{
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
    await tester.enterText(email, 'faculty1@gmail.com');
    await tester.enterText(pwd, 'aaaaaa');
    await tester.pump();

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    print("Signin with email password passed");
    expect(formKey.currentState.validate(), isTrue);
  });
}