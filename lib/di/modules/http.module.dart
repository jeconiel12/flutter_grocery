// coverage:ignore-file
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class HttpInjection {
  http.Client get client => http.Client();
}
