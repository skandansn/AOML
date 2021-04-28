import 'package:aumsodmll/models/od.dart';
import 'package:test/test.dart';
import 'package:aumsodmll/shared/formvalid.dart';

void main() 
{
  test('Given Group OD When writeOnPdf() called Then assign applobjgrp and flag appropriately',(){
    GroupOD grpOD= new GroupOD();
    //od: GroupOD or OD object
    //flagType: true->faculty and false->student
    FormVal wid = new FormVal(od: grpOD, flagType: false);

    //flagpdf: 1->Individual and (not 1)->Group
    wid.createState().writeOnPdf(grpOD, 2);

  });

}