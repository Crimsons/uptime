import 'dart:async';

import 'package:flutter/services.dart';

class Uptime {
  static const MethodChannel _channel = const MethodChannel('uptime');

  static Future<int> get uptime async {
    final int uptime = await _channel.invokeMethod('getUptime');
    return uptime;
  }
}
