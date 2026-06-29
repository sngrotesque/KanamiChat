// lib\pages\home\widgets\news.dart
import 'package:flutter/material.dart';

const double circular = 16; // 圆角

class NewsCard extends StatelessWidget {
  final Map<String, String> newsData;
  final VoidCallback onTap;

  const NewsCard({super.key, required this.newsData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final coverUrl = newsData['cover']!;
    final title = newsData['title']!;

    return GestureDetector(
      onTap: onTap,
      // https://api.flutter.dev/flutter/material/Card-class.html
      child: Card(
        // 卡片标题处的背景颜色
        color: const Color.fromRGBO(255, 255, 255, 0.6),
        elevation: 4, // 阴影大小
        // 下面两个角的圆角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 封面
            ClipRRect(
              // 上面两个角的圆角
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(circular),
              ),
              child: Image.network(
                coverUrl,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
            ),
            // 标题
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 10,
                bottom: 10,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 0.8), // 字体颜色（浅色看不清）
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
