import 'package:logger/logger.dart' as log;

abstract final class AppLogger {
  static final instance = log.Logger();
}
