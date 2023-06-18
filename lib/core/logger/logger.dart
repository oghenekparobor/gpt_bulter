import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class ButlerLogger {
  static void log(message, {StackTrace? stackTrace, data}) {
    if (kDebugMode) {
      Logger().d(message, stackTrace);
    } else {
      // to log tracking service
      // e.g mixpanel, appflyer
    }
  }
}
