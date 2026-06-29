// lib\main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calabiyau_kanami/router.dart'; // 导入路由

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KanamiChat',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          surfaceTint: Colors.transparent,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          decoration: TextDecoration.none,
          decorationColor: Colors.transparent,
          fontFamily: 'Loliti',
        ),
      ),
      routerConfig: appRouter, // 使用 go_router
    );
  }
}
