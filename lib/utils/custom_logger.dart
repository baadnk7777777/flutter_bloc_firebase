import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    filter: null,
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
      noBoxingByDefault: true,
    ),
    output: null,
  );

  static Logger get logger => _logger;

  static void log(String message, String methodName, String? emoji) {
    _logger.i(
      '[$emoji ${DateFormat.jms().format(DateTime.now())}] [$methodName] $message',
    );
  }

  static void logD(String message, String methodName) {
    _logger.d(
      '[${DateFormat.jms().format(DateTime.now())}] [$methodName] $message',
    );
  }

  static void logE(String message, String methodName, String? stackTrace) {
    _logger.e(
      '[${DateFormat.jms().format(DateTime.now())}] [$methodName] $message $stackTrace',
    );
  }
}
