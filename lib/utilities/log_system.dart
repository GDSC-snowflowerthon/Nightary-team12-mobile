import 'package:logger/logger.dart';

abstract class LogSystem {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  static Logger get logger => _logger;
}
