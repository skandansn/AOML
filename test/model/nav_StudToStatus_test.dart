import 'package:aumsodmll/screens/apply/track.dart';
import 'package:aumsodmll/screens/home/homeStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Routes {
  static const STUDENT_HOME_ROUTE = '/';
  static const STATUS_CHECK_ROUTE = '/track';

  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      STATUS_CHECK_ROUTE: (context) => Track(),
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
      Routes.STATUS_CHECK_ROUTE: (context) => _testRoute(Routes.STATUS_CHECK_ROUTE),
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
    final statust = Key("track-status");
    await tester.pumpWidget(_homeWidget());
    _navObserver.attachPushRouteObserver(
        Routes.STATUS_CHECK_ROUTE, () { isPushed = true; });

    //  when
    // await tester.tap(find.byType(ListTile));
    await tester.tap(find.byKey(statust));

    //  then
    expect(isPushed, true);
    print("Navigation from Student home to Track Status successful");
  });
}
