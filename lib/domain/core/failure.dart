import 'dart:io';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

extension ExceptionToFailureExt on Exception {
  static const noInternetError =
      'Please check your internet connection and try again.';
  static const formatError = 'Failed to format incoming data.';

  Failure get toFailure {
    if (this is SocketException) {
      return const Failure(noInternetError);
    } else if (this is FormatException) {
      return const Failure(formatError);
    } else {
      return Failure(toString());
    }
  }
}
