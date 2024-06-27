import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Tools {
  static String getDate(DateTime d) {
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "${d.year}年${d.month}月${d.day}日${weekday[d.weekday]}";
  }

  static String getFullDateTime(DateTime d) {
    return "${d.year}年${d.month}月${d.day}日 ${d.hour}:${d.minute.toString().padLeft(2, '0')}";
  }

  // 计算两个时间间隔多少天
  static String diffDays(DateTime d) {
    return (d.difference(DateTime.now()).inDays.abs() + 1).toString();
  }

  //【马拉松助手】计算还有多少小时
  static String diffHours(DateTime d) {
    return (d.difference(DateTime.now()).inHours -
            d.difference(DateTime.now()).inDays * 24)
        .toString();
  }

  //【马拉松助手】计算还有多少分钟
  static String diffMinutes(DateTime d) {
    return (d.difference(DateTime.now()).inMinutes -
            d.difference(DateTime.now()).inHours * 60)
        .toString()
        .padLeft(2, '0');
  }

  //【马拉松助手】计算还有多少秒
  static String diffSeconds(DateTime d) {
    return (d.difference(DateTime.now()).inSeconds -
            d.difference(DateTime.now()).inMinutes * 60)
        .toString()
        .padLeft(2, '0');
  }

  //* 天气+时间标题
  static String getTitle() {
    DateTime d = DateTime.now();
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    return "🌤️ ${d.month}月${d.day}日 ${weekday[d.weekday]}";
  }

  //* 生成UUID
  static String getUUID() {
    return const Uuid().v1();
  }

  //* 图片保存到临时目录
  static Future<String> writeImageToStorage(
      Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    String response;
    try {
      await screenshotFile.writeAsBytes(feedbackScreenshot);
      response = 'success';
    } catch (error) {
      debugPrint("[Error]${error.toString()}");
      response = error.toString();
    }
    if (response == "success") {
      debugPrint("[Tools]图片保存成功！");
    }
    return screenshotFilePath;
  }

// ? 自定义snackbar Instance member 'mySnackbar' can't be accessed using static access.
  void mySnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
    );
  }
}
