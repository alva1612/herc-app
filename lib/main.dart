import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/config/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(options.baseUrl);
    return MaterialApp.router(
      title: 'Namer App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.red, displayColor: Colors.white)),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}