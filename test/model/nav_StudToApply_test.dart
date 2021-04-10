import 'package:aumsodmll/screens/apply/odApply.dart';
import 'package:aumsodmll/screens/apply/track.dart';
import 'package:aumsodmll/screens/home/homeStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Routes {
  static const STUDENT_HOME_ROUTE = '/';
  static const APPLY_ROUTE = '/od';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      APPLY_ROUTE: (context) => OD(),
      STUDENT_HOME_ROUTE: (context) => HomeStudent("Shakthi Saravanan S") 
      // HomeStudent(title: "Home Screen",)
    };
  }
}

typedef OnObservation = void Function(Route<dynamic> route, Route<dynamic> previousRoute);

class TestNavigatorObserver extends NavigatorObserver {
  OnObservation onPushed;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (onPushed != null) {
      onPushed(route, previousRoute);
    }
  }

  attachPushRouteObserver(String expectedRouteName, Function pushCallback) {
    onPushed = (route, previousRoute) {
      final isExpectedRoutePushed = route.settings.name == expectedRouteName;
      // trigger callback if expected route is pushed
      if(isExpectedRoutePushed) { pushCallback(); }
    };
  }
}

class TestMaterialAppWidget extends StatelessWidget {
  final Widget home;
  final NavigatorObserver navigatorObserver;

  TestMaterialAppWidget({
    Key key,
    this.home,
    this.navigatorObserver
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Test',
      home: home,
      navigatorObservers: [navigatorObserver ?? TestNavigatorObserver()],
      routes: _testRoutes(),
    );
  }

  Map<String, WidgetBuilder> _testRoutes() {
    return <String, WidgetBuilder>{
      Routes.APPLY_ROUTE: (context) => _testRoute(Routes.APPLY_ROUTE),
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

  HomeStudent homePage;
  TestNavigatorObserver _navObserver;

  Widget _homeWidget() {
    return TestMaterialAppWidget(
      home: homePage,
      navigatorObserver: _navObserver,
    );
  }

  setUp(() {
    homePage = HomeStudent("Shakthi Saravanan S");
    _navObserver = TestNavigatorObserver();
  });

  testWidgets('Navigate to Another screen', (WidgetTester tester) async {
    //  given
    var isPushed = false;
    final apply = Key("apply-od");
    await tester.pumpWidget(_homeWidget());
    _navObserver.attachPushRouteObserver(
        Routes.APPLY_ROUTE, () { isPushed = true; });

    //  when
    // await tester.tap(find.byType(ListTile));
    await tester.tap(find.byKey(apply));

    //  then
    expect(isPushed, true);
    print("Navigation from Student home to Apply OD page successful");
  });
}
