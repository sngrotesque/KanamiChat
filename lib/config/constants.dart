import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._(); // 防止被实例化

  static const double appBarHeight    = 32; // AppBar的高度
  static const double bottomBarHeight = 60; // BottomNavigationBar的高度

  // 获取屏幕剩余高度（减去AppBar和状态栏高度后）
  static double getAvailableHeight(BuildContext context, {String? fn}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - topPadding - appBarHeight;

    return availableHeight;
  }
}
