import 'package:aumsodmll/helpers/od_list.dart';
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

  test("When Connection state is waiting then load Loading screen",(){

    ODList od_list = new ODList(flag: true,arg: null);
    bool testsuccesful = false;
    AsyncSnapshot<String> snapshot = AsyncSnapshot.waiting();
    if(od_list.createState().showScreen_with_resp_to_ConnectionState(snapshot) is Loading)
    {
      testsuccesful = true;
    }
    else{
      testsuccesful = false;
    }

    expect(testsuccesful,true);
  });

  test("When snapshot has error print TestWidget with 'Error' ",(){

    ODList od_list = new ODList(flag: true,arg: null);
    bool testsuccesful = false;
    AsyncSnapshot<String> snapshot = AsyncSnapshot.withError(ConnectionState.none, StateError("state error"));

    if(od_list.createState().showScreen_with_resp_to_ConnectionState(snapshot) is Text)
      testsuccesful = true;
    else
      testsuccesful = false;

    expect(testsuccesful,true);
  });

}