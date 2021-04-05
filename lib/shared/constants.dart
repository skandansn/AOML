import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.white),
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    // filled: true,
    // fillColor: Color.fromRGBO(64, 75, 96, .9),
    // focusColor: Color.fromRGBO(64, 75, 96, .9),
    // hoverColor: Color.fromRGBO(64, 75, 96, .9),
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromRGBO(64, 75, 96, .9), width: 2)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2)));

var buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(64, 75, 96, .9)));
