// lib\pages\home\home.dart
import 'package:calabiyau_kanami/config/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/main_04.png'),
          fit: .cover,
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(255, 255, 255, 0.32),
            .lighten,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: AppConstants.appBarHeight / 2),
            Html(data: ''),
          ],
        ),
      ),
    );
  }
}
