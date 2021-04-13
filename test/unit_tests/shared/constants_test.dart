
import 'package:aumsodmll/shared/constants.dart';
import 'package:test/test.dart';

void main()
{
  test('Given an empty string Then validate as "Field cant be empty"',()
  {
    //ARRANGE
    String validated = CommonFieldValidator.validate("");

    //ASSERT
    expect(validated,"Field cant be empty");
  });

  test('Given a string When CommonFieldValidator.validate() called Then ignore',()
  {
    //ARRANGE
    String validated = CommonFieldValidator.validate("Hello");

    //ASSERT
    expect(validated,null);
  });

}