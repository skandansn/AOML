import 'package:aumsodmll/screens/grantGrpOd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aumsodmll/mock.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aumsodmll/shared/loading.dart';


void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  test("When clickedstuid is empty then display 'Please select a student' string", () {
    bool testsuccesful = false;
    var clickedstuid = "";
    if (check_If_StudentID_isClicked(clickedstuid) == "Please select a student") {
      testsuccesful = true;
    }
    else {
      testsuccesful = false;
    }
    expect(testsuccesful, true);
  });

  test("When clickedstuid has an ID then return null", () {
    bool testsuccesful = false;
    var clickedstuid = "20";
    if (check_If_StudentID_isClicked(clickedstuid) == null) {
      testsuccesful = true;
    }
    else {
      testsuccesful = false;
    }
    expect(testsuccesful, true);
  });

  test("When date is not picked then display 'Please enter the date/s' string", () {
    bool testsuccesful = false;
    String date = "";
    if (check_If_Date_isClicked(date) == "Please enter the date/s") {
      testsuccesful = true;
    }
    else {
      testsuccesful = false;
    }
    expect(testsuccesful, true);
  });

  test("If date field is picked then return null", () {
    bool testsuccesful = false;
    String date = "6/19/2021 - 6/30/2021";
    if (check_If_Date_isClicked(date) == null) {
      testsuccesful = true;
    }
    else {
      testsuccesful = false;
    }
    expect(testsuccesful, true);
  });
}