//import 'package:aumsodmll/main.dart';
// import 'package:aumsodmll/screens/home/homeStudent.dart';
// import 'package:aumsodmll/screens/apply/odApply.dart';
import 'package:aumsodmll/screens/login/forgot_password.dart';
import 'package:aumsodmll/screens/login/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';


// class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class Routes {
  static const SIGNIN_ROUTE = '/';
  static const FORGOT_PASSWORD_ROUTE = '/forgotPass';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      FORGOT_PASSWORD_ROUTE: (context) => ForgotPassword(),
      SIGNIN_ROUTE: (context) => SignIn(),
    };
  }}

    

typedef OnObservation = void Function(Route<dynamic> route, Route<dynamic> previousRoute);



class TestNavigatorObserver extends NavigatorObserver {
  OnObservation onPushed;
  OnObservation onPopped;

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPopped != null) {
      onPopped(route, previousRoute);
    }
  }

  attachPopRouteObserver(String expectedRouteName, Function poppedCallback) {
    onPopped = (route, previousRoute) {
      final isExpectedRoutePopped = route.settings.name == expectedRouteName;
      // trigger callback if expected route is popped
      if(isExpectedRoutePopped) { poppedCallback(); }
    };
  }
  
}

class TestMaterialAppWidget extends StatelessWidget {
  final Widget home;
  final NavigatorObserver navigatorObserver;
  final Map<String, WidgetBuilder> routes;

  TestMaterialAppWidget({
    Key key,
    this.home,
    this.navigatorObserver,
    this.routes
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Test',
      home: home,
      navigatorObservers: [navigatorObserver ?? TestNavigatorObserver()],
      routes: routes ?? _testRoutes(),
    );
  }

  Map<String, WidgetBuilder> _testRoutes() {
    return <String, WidgetBuilder>{
      Routes.FORGOT_PASSWORD_ROUTE: (context) => _testRoute(Routes.FORGOT_PASSWORD_ROUTE),
    };
  }

  _testRoute(String routeName) => DummyTestRoute(routeName: routeName);
}

class DummyTestRoute extends StatelessWidget {
  final String routeName;

  DummyTestRoute({Key key, this.routeName}): super(key: key ?? Key(routeName));

  @override
  Widget build(BuildContext context) => Text(routeName);

}

void main() {
  TestNavigatorObserver _navObserver;

  Widget _testHomePage() {
    return TestMaterialAppWidget(
      home: SignIn(),
      navigatorObserver: _navObserver,
      routes: _routes(),
    );
  }

  setUp(() {
   _navObserver = TestNavigatorObserver();
  });

  Future _pumpAnotherPage(WidgetTester tester) async {
    await tester.pumpWidget(_testHomePage()); // Push a TestHomePage as start page
    await tester.tap(find.byType(TextButton)); // Tap to push AnotherPage
    await tester.pumpAndSettle(); // Flushes any pending tasks like animations etc.
  }

 testWidgets("Sign in button tap should pop SignIn page", (WidgetTester tester) async {
    //  given
    await _pumpAnotherPage(tester);
    var isPopped = false;
    _navObserver.attachPopRouteObserver(
        Routes.FORGOT_PASSWORD_ROUTE, () { isPopped = true; });

    //  when
    await tester.tap(find.text("Sign in"));

    //  then
    expect(isPopped, isTrue);
    print("Popped Back to signIn page");
  });

}

Map<String, WidgetBuilder> _routes() {
  return <String, WidgetBuilder>{
    Routes.FORGOT_PASSWORD_ROUTE: (context) => ForgotPassword(),
  };
}

// class TestHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => TextButton(onPressed: () {
//       Navigator.pushNamed(context, Routes.FORGOT_PASSWORD_ROUTE);
//       });
// }