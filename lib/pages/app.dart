// lib\pages\app.dart
import 'package:flutter/material.dart';

import 'package:calabiyau_kanami/config/constants.dart';
import 'package:calabiyau_kanami/config/exception.dart';

import 'package:calabiyau_kanami/pages/home/home.dart';
import 'package:calabiyau_kanami/pages/chat/chat.dart';
import 'package:calabiyau_kanami/pages/profile/profile.dart';

class App extends StatelessWidget {
  const App({super.key});

  ThemeData buildTheme() {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: .fromSeed(
        seedColor: Colors.blue,
        surfaceTint: Colors.transparent,
      ),
    );

    final textTheme = baseTheme.textTheme;
    return baseTheme.copyWith(
      textTheme: textTheme.apply(
        decoration: TextDecoration.none,
        decorationColor: Colors.transparent,
        fontFamily: 'Loliti',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'none', theme: buildTheme(), home: const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 变量定义
  final navStyle = BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue[600],
    unselectedItemColor: Colors.grey[400],
  );
  final List<Widget> pages = [
    const HomePage(),
    const ChatPage(),
    const ProfilePage(),
  ];
  int currentSelectedIndex = 0;

  /// 方法定义
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 允许body内容延伸到 App 和 BottomNav 后面
      extendBodyBehindAppBar: true,
      extendBody: true,

      appBar: buildAppBarView('KanamiChat'),
      body: IndexedStack(index: currentSelectedIndex, children: pages),
      bottomNavigationBar: buildBottomNavigationBarView(),
    );
  }

  PreferredSize buildAppBarView(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.appBarHeight),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // 添加 AppBar 的透明效果（保持文本原透明度）
              Color.fromRGBO(0, 0, 255, 0.5),
              Color.fromRGBO(233, 30, 99, 0.5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: .end,
          children: [
            Padding(
              padding: const .symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarTheme buildBottomNavigationBarView() {
    return BottomNavigationBarTheme(
      data: navStyle,
      child: Theme(
        // 局部覆盖主题
        data: Theme.of(context).copyWith(
          // 去掉水波纹效果
          splashFactory: NoSplash.splashFactory,
          // 画布颜色、背景色调成透明，否则 BottomNavigationBar 内部会有默认白底
          canvasColor: Colors.transparent,
        ),
        child: Container(
          // BottomNavigationBar 的高度调整
          height: AppConstants.bottomBarHeight,
          decoration: BoxDecoration(
            // BottomNavBar 白色覆盖层
            color: Colors.white.withValues(alpha: 0.5),
            // 加一个淡淡的香奈美粉色线
            border: Border(
              top: BorderSide(color: buildBottomBarColor(2, 0.2), width: 0.5),
            ),
          ),
          child: BottomNavigationBar(
            // 强制四个图标平分屏幕宽度，不再进行任何动态位移
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            // 去掉阴影，防止出现黑色黑边
            elevation: 0,

            // 这里的颜色会自动作用于 Icon 和 Image（只要 Image 没写死 color）
            selectedItemColor: navStyle.selectedItemColor,
            unselectedItemColor: navStyle.unselectedItemColor,

            // 当中选中项
            currentIndex: currentSelectedIndex,

            // 当点击时更新索引并刷新UI
            onTap: (index) {
              setState(() {
                currentSelectedIndex = index;
              });
            },

            // 具体项
            items: [
              buildNavItem('assets/images/icons/home_01.png', '主页', 0),
              buildNavItem('assets/images/icons/chat_01.png', '聊天', 1),
              buildNavItem('assets/images/icons/user_profile_01.png', '我的', 2),
            ],
          ),
        ),
      ),
    );
  }

  Color buildBottomBarColor(int index, double algha) {
    final List<Color> bottomBarBorderTopLineColor = [
      // 白色头发（带点紫色）
      Color.fromRGBO(180, 162, 216, algha),
      Color.fromRGBO(217, 205, 238, algha),
      // 粉色鬓发
      Color.fromRGBO(243, 161, 222, algha),
    ];

    if ((index < 0) || (index >= bottomBarBorderTopLineColor.length)) {
      throw KanamiChatException(
        'buildBottomBarLine',
        'index 必须大于等于 0 且小于 ${bottomBarBorderTopLineColor.length}。',
      );
    }
    if ((algha < 0) || (algha > 1)) {
      throw KanamiChatException('buildBottomBarLine', 'algha 必须大于等于 0 且小于 1。');
    }

    return bottomBarBorderTopLineColor[index];
  }

  BottomNavigationBarItem buildNavItem(
    String iconPath,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: () {
          return (currentSelectedIndex == index)
              ? navStyle.selectedItemColor
              : navStyle.unselectedItemColor;
        }(),
      ),
      label: label,
    );
  }
}
