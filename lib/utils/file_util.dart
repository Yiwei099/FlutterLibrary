import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class FileUtil {
  //<editor-fold desc="单例的实现"》
  //静态属性——该类的实例
  static FileUtil? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  FileUtil._internal();

  static FileUtil getInstance() {
    _instance ??= FileUtil._internal();
    return _instance!;
  }

  //</editor-fold desc="单例的实现"》

  Future<File?> compressImageToTargetSize({
    required File inputFile,
    required int targetSizeKB, // 目标大小（单位KB）
    int minQuality = 10, // 最小质量（0-100）
    int maxQuality = 100, // 最大质量（0-100）
    int maxAttempts = 10, // 最大尝试次数（避免无限循环）
  }) async {
    XFile? compressedFile;
    int currentQuality = maxQuality;
    int lowerBound = minQuality;
    int upperBound = maxQuality;

    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      // 压缩图片
      compressedFile = (await FlutterImageCompress.compressAndGetFile(
        inputFile.path,
        '${inputFile.path}_compressed.jpg',
        quality: currentQuality,
        minWidth: 800, // 限制宽度（可选）
        minHeight: 800, // 限制高度（可选）
      ));

      if (compressedFile == null) return null;

      File realFile = File(compressedFile.path);

      // 检查文件大小

      final compressedSizeKB = realFile.lengthSync() ~/ 1024;
      debugPrint(
        'Attempt $attempt: Quality=$currentQuality, Size=${compressedSizeKB}KB',
      );

      if (compressedSizeKB <= targetSizeKB) {
        return realFile; // 达到目标大小
      } else {
        // 未达标，调整质量范围（二分查找）
        upperBound = currentQuality - 1;
        currentQuality = ((lowerBound + upperBound) / 2).round();
      }
    }

    if(compressedFile != null) {
      return File(compressedFile.path); // 返回最后一次压缩结果
    }

    return inputFile;
  }
}
