// lib\main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:calabiyau_kanami/pages/app.dart';

void main() async
{
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    )
  );

  runApp(const App());
}
