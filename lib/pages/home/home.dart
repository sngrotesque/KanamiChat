// lib\pages\home\home.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calabiyau_kanami/config/constants.dart';
import 'package:calabiyau_kanami/pages/home/widgets/fetch.dart';
import 'package:calabiyau_kanami/pages/home/widgets/news.dart'; // 新闻卡片组件

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
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(255, 255, 255, 0.32),
            BlendMode.lighten,
          ),
        ),
      ),
      child: FutureBuilder<List<Map<String, String>>>(
        future: fetchListOfNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '加载失败：${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final newsList = snapshot.data!;
          if (newsList.isEmpty) {
            return const Center(child: Text('暂无资讯'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: AppConstants.appBarHeight + 20,
              bottom: AppConstants.bottomBarHeight + 20,
            ),
            child: Column(
              children: newsList.map((news) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: NewsCard(
                    newsData: news,
                    onTap: () {
                      // 跳转到详情页，传递 news 数据
                      context.push('/news-detail', extra: news);
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
