import 'package:hayer_server/src/places/google_response.dart';
import 'package:test/test.dart';

void main() {
  test('strips the XSSI guard and navigates safely', () {
    final response = GoogleResponse.parse(")]}'\n[[null,[42]]]");

    expect(response.intAt(const [0, 1, 0]), 42);
    expect(response.at(const [99, 0]), isNull);
    expect(response.at(const [-1]), isNull);
  });
}
