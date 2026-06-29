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
    // 新闻详情页（独立路由，不显示底部导航）
    GoRoute(
      path: '/news-detail',
      builder: (context, state) {
        // 从 extra 中获取新闻数据（url 等）
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
  late int _currentIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 根据当前路由计算底部导航索引
    final location = GoRouterState.of(context).uri.toString();
    _currentIndex = _calculateIndex(location);
  }

  static int _calculateIndex(String location) {
    if (location.startsWith('/chat')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0; // /home
  }

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
    final location = GoRouterState.of(context).uri.toString();
    _currentIndex = _calculateIndex(location);

    // 此处复用你原有的 AppBar 和 BottomNavigationBar 样式
    final navStyle = BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue[600],
      unselectedItemColor: Colors.grey[400],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppConstants.appBarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
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
                  children: const [
                    Text(
                      'KanamiChat',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: widget.child, // 当前页面内容
      bottomNavigationBar: BottomNavigationBarTheme(
        data: navStyle,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            canvasColor: Colors.transparent,
          ),
          child: Container(
            height: AppConstants.bottomBarHeight,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              border: const Border(
                top: BorderSide(
                  color: Color.fromRGBO(180, 162, 216, 0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: navStyle.selectedItemColor,
              unselectedItemColor: navStyle.unselectedItemColor,
              currentIndex: _currentIndex,
              onTap: _onTap,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/home_01.png',
                    width: 24,
                    height: 24,
                    color: _currentIndex == 0
                        ? navStyle.selectedItemColor
                        : navStyle.unselectedItemColor,
                  ),
                  label: '主页',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/chat_01.png',
                    width: 24,
                    height: 24,
                    color: _currentIndex == 1
                        ? navStyle.selectedItemColor
                        : navStyle.unselectedItemColor,
                  ),
                  label: '聊天',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/user_profile_01.png',
                    width: 24,
                    height: 24,
                    color: _currentIndex == 2
                        ? navStyle.selectedItemColor
                        : navStyle.unselectedItemColor,
                  ),
                  label: '我的',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
