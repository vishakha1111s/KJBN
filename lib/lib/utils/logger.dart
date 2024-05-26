
import 'dart:core';
import 'dart:developer' as developer;

class AppLogger {
  static log(String message, {String? tag}) {
    developer.log(message, name: tag ?? "AppLogger:");
    print("${tag ?? "AppLogger:"} : $message");
  }
}
