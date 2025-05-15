import 'package:flutter/material.dart';
import 'package:waterapp/app/dependency_inj.dart';

class AppInitializer {
  static Future<void> preRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDependencyInj();
  }
}
