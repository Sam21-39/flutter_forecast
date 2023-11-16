import 'package:logger/logger.dart';

class Log {
  static showLog(String log) {
    final Logger logger = Logger();
    return logger.d(
      log,
      time: DateTime.now().toLocal(),
    );
  }
}
