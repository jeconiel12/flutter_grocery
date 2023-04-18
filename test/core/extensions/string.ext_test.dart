import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_grocery/core/core.dart';

void main() {
  group('StringExtension', () {
    test('toIDR should format string as Indonesian Rupiah currency', () {
      final result1 = '10000'.toIDR();
      expect(result1, 'Rp 10.000');

      final result2 = '500000'.toIDR();
      expect(result2, 'Rp 500.000');

      final result3 = '1200000'.toIDR();
      expect(result3, 'Rp 1.200.000');
    });

    test('toIDR should return Rp 0 when the string is not a valid number', () {
      final result = 'not a number'.toIDR();
      expect(result, 'Rp 0');
    });
  });
}
