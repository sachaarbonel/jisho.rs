import 'dart:async';

import 'package:flutter/services.dart';

class Jisho {
  static const MethodChannel _channel =
      const MethodChannel('jisho');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
