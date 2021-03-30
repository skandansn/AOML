// import 'package:flutter/material.dart';
// import 'screens/apply/fill_in_details.dart';
// import 'screens/apply/od.dart';
// class RouteGenerator{
//   static Route<dynamic> generateRoute(RouteSettings settings)
//   {
//     final args = settings.arguments;

//     switch(settings.name)
//     {
//       case '/':
//         return MaterialPageRoute(builder: (_) => OD());
//       case '/fillIn':
//         return MaterialPageRoute(builder: (_) => ApplicationForm());
//       default:
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute()
//   {
//     return MaterialPageRoute(builder: (_){
//       return Scaffold(
//         appBar: AppBar(
//           title:Text("Error"),
//         ),
//         body: Center(
//           child: Text("ERROR!"),
//         )
//       );
//     });
//   }
// }