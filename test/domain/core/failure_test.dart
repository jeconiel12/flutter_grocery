import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_grocery/domain/core/core.dart';

void main() {
  group('ExceptionToFailureExt', () {
    group('toFailure', () {
      test('return Failure with correct message for [SocketException]', () {
        const exception = SocketException('No Internet');
        const message = ExceptionToFailureExt.noInternetError;

        expect(exception.toFailure, const Failure(message));
      });

      test('return Failure with correct message for [FormatException]', () {
        const exception = FormatException('Formating Error');
        const message = ExceptionToFailureExt.formatError;

        expect(exception.toFailure, const Failure(message));
      });

      test('return Failure with exception message for other exceptions', () {
        final exception = Exception('Unknown error');

        expect(exception.toFailure, Failure(exception.toString()));
      });
    });
  });
}
