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
      // 背景图像设置
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
      // 因为 fetchListOfNews 是 List<Map<String, String>>，所以 FutureBuilder<T> 是 List<Map<String, String>>。
      child: FutureBuilder<List<Map<String, String>>>(
        future: fetchListOfNews(), // 要监听的异步任务
        /**
         * builder: 一个回调函数，每次状态改变时都会重新调用。它接收两个参数：
         *    context: 当前上下文
         *    snapshot：AsyncSnapshot<List<Map<String, String>>> 类型，包含了连接状态和数据。
         */
        builder: (context, snapshot) {
          /**
           * builder 里根据 snapshot.connectionState 返回不同的 Widget
           *      状态：ConnectionState.waiting
           *      含义：还在请求数据中
           *      返回：一个转圈加载动画
           * 
           *      状态：ConnectionState.done 且有数据
           *      含义：成功拿到 HTML
           *      返回：用 Html(data: ...) 显示
           * 
           *      状态：ConnectionState.done 且出错
           *      含义：网络错误或解析失败
           *      返回：显示错误文字
           */
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
              top: AppConstants.appBarHeight + 32,
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
