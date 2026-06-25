import 'package:flutter/material.dart';

import 'package:calabiyau_kanami/pages/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  ThemeData buildTheme() {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: .fromSeed(
        seedColor: Colors.blue,
        surfaceTint: Colors.transparent
      )
    );

    final textTheme = baseTheme.textTheme;
    return baseTheme.copyWith(
      textTheme: textTheme.apply(
        decoration: TextDecoration.none,
        decorationColor: Colors.transparent,
        fontFamily: 'Loliti',
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'none',
      theme: buildTheme(),
      home: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return const HomePage();
    return Scaffold(
      // appBar: ,
      body: const HomePage(),
      // bottomNavigationBar: ,
    );
  }
}
