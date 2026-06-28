import 'package:flutter/material.dart';

import 'package:calabiyau_kanami/config/constants.dart';
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
    unselectedItemColor: Colors.grey[200],
  );
  int currentSelectedIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  /// 方法定义
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarView('Test title'),
      body: IndexedStack(index: currentSelectedIndex, children: pages),
      bottomNavigationBar: buildBottomNavigationBarView(),
    );
  }

  PreferredSize buildAppBarView(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.appBarHeight),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.pink]),
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, size: 20),
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
          splashFactory: NoSplash.splashFactory, // 去掉水波纹效果
        ),
        child: BottomNavigationBar(
          // 强制四个图标平分屏幕宽度，不再进行任何动态位移
          type: BottomNavigationBarType.fixed,

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
    );
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
