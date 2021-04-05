import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
    // fillColor: Colors.white,
    filled: true,
    fillColor: Color.fromRGBO(64, 75, 96, .9),
    focusColor: Color.fromRGBO(64, 75, 96, .9),
    hoverColor: Color.fromRGBO(64, 75, 96, .9),
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(64, 75, 96, .9), width: 2)),
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(64, 75, 96, .9), width: 2)));
var buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(64, 75, 96, .9)));
