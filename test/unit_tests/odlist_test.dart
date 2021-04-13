import 'package:aumsodmll/models/od.dart';
//import 'package:provider/provider.dart';
import 'package:test/test.dart';

adderfn(dynamic ods) {
  var arr = [];

  if (ods != null) {
    ods.forEach((element) {
      arr.add(element);
    });
  }
  if ((arr.length) != 0) {
    return true;
  }
  return false;
}

void main() {
  test("Add to array tester", () {
    OD a = new OD();
    OD b = new OD();
    final ods = [a, b];
    var result = adderfn(ods);

    expect(result, true);
  });
}
