// lib/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:calabiyau_kanami/pages/home/home.dart';
import 'package:calabiyau_kanami/pages/home/news_detail.dart';
import 'package:calabiyau_kanami/pages/chat/chat.dart';
import 'package:calabiyau_kanami/pages/profile/profile.dart';
import 'package:calabiyau_kanami/config/constants.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    // 底部导航栏作为 Shell
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: '/chat',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ChatPage()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage()),
        ),
      ],
    ),
    // 资讯详情页（独立路由，不显示底部导航）
    GoRoute(
      path: '/news-detail',
      builder: (context, state) {
        // 从 extra 中获取资讯数据（url 等）
        final newsData = state.extra as Map<String, String>;
        return NewsDetailPage(newsData: newsData);
      },
    ),
  ],
);

// 带底部导航栏的 Scaffold
class ScaffoldWithNavBar extends StatefulWidget {
  final Widget child;
  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  late int _currentIndex; // 当前页面的下标

  // 当此状态对象的依赖项发生变化时调用。
  // https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 根据当前路由计算底部导航索引
    final location = GoRouterState.of(context).uri.toString();
    _currentIndex = _calculateIndex(location);
  }

  // 计算下标
  static int _calculateIndex(String location) {
    if (location.startsWith('/chat')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0; // /home
  }

  // 根据下标跳转对应页面
  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/chat');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 当路由变化时更新选中索引
    final String location = GoRouterState.of(context).uri.toString();
    _currentIndex = _calculateIndex(location);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: buildAppBarView('Kanami Chat'),
      body: widget.child, // 当前页面内容
      bottomNavigationBar: buildBottomNavigationBarView(),
    );
  }

  PreferredSize buildAppBarView(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppConstants.appBarHeight),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // 添加 AppBar 的透明效果（保持文本原透明度）
            colors: [
              Color.fromRGBO(0, 0, 255, 0.5),
              Color.fromRGBO(233, 30, 99, 0.5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
        data: Theme.of(context).copyWith(
          // 去掉水波纹效果
          splashFactory: NoSplash.splashFactory,
          // 画布颜色和背景色调成透明，否则内部会有默认白底
          canvasColor: Colors.transparent,
        ),
        child: Container(
          // 底栏高度
          height: AppConstants.bottomBarHeight,
          decoration: BoxDecoration(
            // BottomNavBar 白色覆盖层（最终决定颜色）
            color: Colors.white.withValues(alpha: 0.85),
            // 加一个淡淡的香奈美粉色线
            border: const Border(
              top: BorderSide(
                color: Color.fromRGBO(180, 162, 216, 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // 平分屏幕宽度
            backgroundColor: Colors.transparent,
            elevation: 0, // 去掉阴影，防止出现黑边
            selectedItemColor: navStyle.selectedItemColor,
            unselectedItemColor: navStyle.unselectedItemColor,
            currentIndex: _currentIndex,
            onTap: _onTap, // 点击时跳转页面
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
        color: _currentIndex == index
            ? navStyle.selectedItemColor
            : navStyle.unselectedItemColor,
      ),
      label: label,
    );
  }

  final navStyle = BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue[600],
    unselectedItemColor: Colors.grey[400],
  );
}
