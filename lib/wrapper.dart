import 'package:aumsodmll/models/user.dart';
import 'package:aumsodmll/screens/authenticate.dart';
import 'package:aumsodmll/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
