// lib/pages/home/news_detail.dart
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:calabiyau_kanami/pages/home/widgets/fetch.dart';

class NewsDetailPage extends StatefulWidget {
  final Map<String, String> newsData;
  const NewsDetailPage({super.key, required this.newsData});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late Future<String> _htmlFuture;

  @override
  void initState() {
    super.initState();
    // 页面加载时自己调用 fetchNews 获取正文
    _htmlFuture = fetchNews(widget.newsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsData['title'] ?? '资讯详情'),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      ),
      body: FutureBuilder<String>(
        future: _htmlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '加载失败：${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }
          final htmlContent = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Html(data: htmlContent),
          );
        },
      ),
    );
  }
}
