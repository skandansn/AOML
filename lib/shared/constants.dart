import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
    // fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey[600], width: 2)));
var buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blueGrey[600]));
