// lib\pages\home\widgets\news.dart
import 'package:flutter/material.dart';

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
      child: Card(
        color: const Color.fromRGBO(255, 255, 255, 0.85),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 封面
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
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
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
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
