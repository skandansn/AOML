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
group("SignIn page testing", (){
  testWidgets('Check for necessary components in the Login page', (WidgetTester tester)async{
    final AuthService auth = AuthService();
     await tester.pumpWidget(createWidgetForTesting(child:new SignIn()));
    // Finder img = find.byKey(new Key("image-field"));
    final email = Key('email-field');
    final pwd = Key('password-field');
    final signin = Key('email-field');
    final forgotp = Key('password-field');
    expect(find.byKey(email),findsOneWidget);
    print("Found email field");
    expect(find.byKey(pwd),findsOneWidget);
    print("Found password field");
    expect(find.byKey(signin),findsOneWidget);
    print("Found signin button");
    expect(find.byKey(forgotp),findsOneWidget);
    print("Found forgot password button");

  });
  testWidgets('Empty email and password', (WidgetTester tester)async{
    await tester.pumpWidget(createWidgetForTesting(child:new SignIn()));
    // Finder img = find.byKey(new Key("image-field"));
    Finder email = find.byKey(new Key('email-field'));
    //Finder pwd = find.byKey(new Key('password-field'));
    // provideMockedNetworkImages(()async{
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Image.network("'https://i.imgur.com/pQR0s45.jpg'")
    //     )
    //   );
    // });
    print("Getting email widget");
    print(email.toString());
    print("Getting form widget");
    Finder formWidgetFinder = find.byType(Form);
    print(formWidgetFinder.toString());
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    expect(formKey.currentState.validate(), isFalse);
  });
    testWidgets("SignIn with email and password-Student",(WidgetTester tester)async{
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
    await tester.enterText(email, 'shakthiboy@gmail.com');
    await tester.enterText(pwd, 'aaaaaa');
    await tester.pump();

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    print("Signin with email password passed");
    expect(formKey.currentState.validate(), isTrue);
  });

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

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
    print("Signin with invalid email password should not pass and the test should fail.");
    expect(formKey.currentState.validate(), isFalse);
  });

});
  
}