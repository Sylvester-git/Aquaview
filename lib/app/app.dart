import 'package:flutter/material.dart';
import 'package:waterapp/features/dashboard/dashboard.dart';
import 'package:waterapp/util/theme.dart';

class RootApp extends StatelessWidget {
  const RootApp._();

  static final instance = RootApp._();

  factory RootApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
