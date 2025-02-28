import 'package:logger/logger.dart';

abstract class Log {
  static final Logger _logger = Logger();

  static void error(message) {
    _logger.e(message);
  }

  static void debug(message) {
    _logger.d(message);
  }

  static void warning(message) {
    _logger.w(message);
  }

  static void wtf(message) {
    _logger.wtf(message);
  }

  static void info(message) {
    _logger.i(message);
  }

  static void verbose(message) {
    _logger.v(message);
  }
}
