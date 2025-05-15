import 'package:flutter/material.dart';
import 'package:waterapp/app/provider.dart';
import 'package:waterapp/util/route.dart';
import 'package:waterapp/util/theme.dart';

class RootApp extends StatelessWidget {
  const RootApp._();

  static final instance = RootApp._();

  factory RootApp() => instance;

  @override
  Widget build(BuildContext context) {
    return getProvider(
      child: MaterialApp.router(
        theme: getDarkTheme(),
        debugShowCheckedModeBanner: false,
        routeInformationParser: route.routeInformationParser,
        routerDelegate: route.routerDelegate,
        routeInformationProvider: route.routeInformationProvider,
      ),
    );
  }
}
