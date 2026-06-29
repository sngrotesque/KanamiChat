// lib/pages/home/news_detail.dart
import 'package:calabiyau_kanami/pages/home/widgets/fetch.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatefulWidget {
  final Map<String, String> newsData;
  const NewsDetailPage({super.key, required this.newsData});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late Future<String> _htmlFuture;

  // 页面加载时自己调用 fetchNews 获取正文
  @override
  void initState() {
    super.initState();
    _htmlFuture = fetchNews(widget.newsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 234, 231, 1),
      appBar: AppBar(
        title: Text(widget.newsData['title'] ?? '资讯详情'),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.45),
      ),
      // 因为 _htmlFuture 是 String，所以 FutureBuilder<T> 是 String。
      body: FutureBuilder<String>(
        // 要监听的异步任务；你交给它一个 Future 对象，它会自动订阅这个 Future 的状态。
        future: _htmlFuture,
        /**
         * builder: 一个回调函数，每次状态改变时都会重新调用。它接收两个参数：
         *    context: 当前上下文
         *    snapshot：AsyncSnapshot<String> 类型，包含了连接状态和数据。
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '加载失败：${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }
          final String htmlContent = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Html(
              data: htmlContent,
              extensions: [TableHtmlExtension()],
              style: {
                "body": Style(color: Colors.black87, fontSize: FontSize(16)),
                "table": Style(
                  border: Border.all(color: Colors.grey),
                  margin: Margins.only(top: 8, bottom: 8), // 使用 Margins
                ),
                "th": Style(
                  padding: HtmlPaddings.all(6), // 使用 HtmlPaddings
                  border: Border.all(color: Colors.grey),
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.grey[100],
                ),
                "td": Style(
                  padding: HtmlPaddings.all(6), // 使用 HtmlPaddings
                  border: Border.all(color: Colors.grey),
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
