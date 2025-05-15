import 'dart:convert';

import 'package:flutter/services.dart';

class ConfigServices {
  static Map<String, dynamic> _config = {};

  static Future<void> loadConfig() async {
    final configString = await rootBundle.loadString('assets/env.json');
    _config = json.decode(configString);
  }

  /// Retrieves a value from the loaded config file.
  ///
  /// Returns [defaultValue] if the key is not found.
  static String get(String key, {String defaultValue = ''}) {
    return _config[key]?.toString() ?? defaultValue;
  }

  /// Optional: check if config has been loaded
  static bool get isLoaded => _config.isNotEmpty;
}
