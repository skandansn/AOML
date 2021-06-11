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
  testWidgets('Check for necessary components in the Login page', (WidgetTester tester)async{
    // final AuthService auth = AuthService();
     await tester.pumpWidget(createWidgetForTesting(child:new SignIn()));
    // Finder img = find.byKey(new Key("image-field"));
    final img = Key('emblem-image');
    final email = Key('email-field');
    final pwd = Key('password-field');
    final signin = Key('email-field');
    final forgotp = Key('password-field');
    expect(find.byKey(img),findsOneWidget);
    print("Found Emblem");
    expect(find.byKey(email),findsOneWidget);
    print("Found email field");
    expect(find.byKey(pwd),findsOneWidget);
    print("Found password field");
    expect(find.byKey(signin),findsOneWidget);
    print("Found signin button");
    expect(find.byKey(forgotp),findsOneWidget);
    print("Found forgot password button");

  });
}