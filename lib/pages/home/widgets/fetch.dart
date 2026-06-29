// lib\pages\home\widgets\fetch.dart
import 'package:calabiyau_kanami/config/constants.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:dio/dio.dart';

/// 获取资讯列表（跳过第一条）
/// [page] 页码，默认为 1
/// [displayQuantity] 每页数量，默认为 5（对应 Python 中的 4+1）
Future<List<Map<String, String>>> fetchListOfNews({
  int page = 1,
  int displayQuantity = 5,
}) async {
  final url =
      'https://klbq-prod-www.idreamsky.com/api/news?p=$page&ps=$displayQuantity';
  final headers = {'User-Agent': userAgentList.choice()};

  final dio = Dio();
  final response = await dio.get(url, options: Options(headers: headers));

  final List list = response.data['data']['list'];
  final result = <Map<String, String>>[];

  // 跳过第一条
  for (int i = 1; i < list.length; i++) {
    final item = list[i];
    result.add({
      'title': item['title'] as String, // 标题
      'url': 'https://klbq.idreamsky.com/newsDetails?id=${item['url']}', // 正文链接
      'cover': item['cover'] as String, // 封面
    });
  }

  return result;
}

/// 获取单篇资讯的正文 HTML 内容
/// [data] 必须包含 'url' 键
Future<String> fetchNews(Map<String, String> data) async {
  final url = data['url']!;
  final headers = {'User-Agent': userAgentList.choice()};

  final dio = Dio();
  final response = await dio.get(url, options: Options(headers: headers));

  final htmlString = response.data as String;
  final document = html_parser.parse(htmlString);
  final element = document.querySelector('div.ql-editor');

  if (element == null) {
    throw Exception('Could not find div.ql-editor in the page');
  }

  return element.innerHtml;
}
