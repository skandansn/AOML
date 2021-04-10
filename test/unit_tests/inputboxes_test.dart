import 'package:aumsodmll/shared/constants.dart';
import 'package:test/test.dart';

void main() {
  test('Field empty tester', () {
    var result = CommonFieldValidator.validate("");
    expect(result, "Field cant be empty");
  });
  test('Non empty Field tester', () {
    var result = CommonFieldValidator.validate("emailaddress");
    expect(result, null);
  });
  test('Wrong email format tester', () {
    var result = EmailFieldValidator.validate("ask123");
    expect(result, null);
  });
  test('Email field tester', () {
    var result = EmailFieldValidator.validate("Aa@a.com");
    expect(result, "Valid email address");
  });
}
