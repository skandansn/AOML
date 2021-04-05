import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Center(
        child: SpinKitDoubleBounce(
          color: Color.fromRGBO(64, 75, 96, .9),
          size: 50.0,
        ),
      ),
    );
  }
}
