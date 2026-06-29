import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DebugFileWriter {
  static Future<String> writeLog(String fileName, dynamic content, {bool append = false}) async {
    try {
      String basePath = '';

      if (Platform.isAndroid) {
        // 1. Android 获取外部存储目录：通常对应 /storage/emulated/0/Android/data/包名/files
        // 这个路径虽然在 Android 文件夹下，但用户可以用手机自带的文件管理器（或电脑连接）直接进去！
        final extDir = await getExternalStorageDirectory();
        basePath = extDir?.path ?? '';
      } else {
        // 2. Windows / Linux 直接放到电脑的“下载(Downloads)”或者“文档”文件夹，绝对好找
        final downloadDir = await getDownloadsDirectory();
        basePath = downloadDir?.path ?? '';
      }

      final filePath = p.join(basePath, fileName);
      final file = File(filePath);

      // 格式化内容
      String stringContent = (content is String) 
          ? content 
          : const JsonEncoder.withIndent('  ').convert(content);

      if (append) {
        await file.writeAsString('$stringContent\n', mode: FileMode.append);
      } else {
        await file.writeAsString(stringContent, mode: FileMode.write);
      }

      // 关键：把绝对路径完整打印出来，方便直接复制
      debugPrint('✏️ 调试文件绝对路径: ${file.absolute.path}');
      return file.absolute.path;
    } catch (e) {
      debugPrint('❌ 写入调试文件失败: $e');
      return '';
    }
  }
}
