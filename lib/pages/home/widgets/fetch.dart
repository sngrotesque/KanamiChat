import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;

/// 获取新闻列表（跳过第一条）
/// [page] 页码，默认为 1
/// [displayQuantity] 每页数量，默认为 5（对应 Python 中的 4+1）
Future<List<Map<String, String>>> fetchListOfNews({
  int page = 1,
  int displayQuantity = 5,
}) async {
  final url =
      'https://klbq-prod-www.idreamsky.com/api/news?p=$page&ps=$displayQuantity';

  final headers = {
    'Referer': 'https://klbq.idreamsky.com/',
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64; rv:151.0) Gecko/20100101 Firefox/151.0',
  };

  final dio = Dio();
  final response = await dio.get(url, options: Options(headers: headers));

  // dio 默认对非 2xx 状态码抛出异常，这里直接使用数据即可
  final List list = response.data['data']['list'];
  final result = <Map<String, String>>[];

  // 跳过第一条（索引从 1 开始）
  for (int i = 1; i < list.length; i++) {
    final item = list[i];
    result.add({
      'title': item['title'] as String,
      'url': 'https://klbq.idreamsky.com/newsDetails?id=${item['url']}',
      'cover': item['cover'] as String,
    });
  }

  return result;
}

/// 获取单篇新闻的正文 HTML 内容
/// [data] 必须包含 'url' 键
Future<String> fetchNews(Map<String, String> data) async {
  final url = data['url']!;

  final headers = {
    'Referer': 'https://klbq.idreamsky.com/',
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64; rv:151.0) Gecko/20100101 Firefox/151.0',
  };

  final dio = Dio();
  final response = await dio.get(url, options: Options(headers: headers));

  final htmlString = response.data as String;
  final document = html_parser.parse(htmlString);
  final element = document.querySelector('div.ql-editor');

  if (element == null) {
    throw Exception('Could not find div.ql-editor in the page');
  }

  // 对应 BeautifulSoup 的 decode_contents()
  return element.innerHtml;
}
