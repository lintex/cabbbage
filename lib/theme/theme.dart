import 'package:flutter/material.dart';

//日间模式
Color bg = const Color.fromARGB(255, 244, 245, 247);
Color blue = const Color.fromARGB(255, 52, 131, 252);
Color blueBg = const Color.fromARGB(255, 222, 239, 255);
Color greyBg = const Color.fromARGB(255, 247, 247, 247);
Color yellow = const Color.fromARGB(255, 236, 176, 56);
Color red = const Color.fromARGB(255, 193, 56, 72);
Color grey = const Color.fromARGB(255, 159, 159, 159);
// 日间模式
// 按钮背景 240,240,240
// 蓝色按钮背景 52,130,255 按钮文字255
// 蓝色listTile背景 234,242,255 文字 61,129,240

// 暗黑模式
// 纯黑背景  0,  0,  0 文字 143,143,143  亮色161,灰色72
// 弹出窗口背景 36, 36, 36 文字234
// 按钮背景  69, 69, 69  按钮文字 200,200,200
// 蓝色按钮背景 38,122,247 按钮文字 234,242,253

Color blackBg = const Color.fromARGB(255, 36, 36, 36);
Color greyText = const Color.fromARGB(255, 50, 50, 50);
Color whiteText = const Color.fromARGB(255, 229, 229, 229);

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: greyBg),
    scaffoldBackgroundColor: greyBg,
    colorScheme: ColorScheme.light(
      background: const Color.fromARGB(255, 247, 247, 247),
      primary: Colors.grey[300]!,
      secondary: Colors.grey[400]!,
      tertiary: Colors.grey[500]!,
      inversePrimary: Colors.black87,
      outline: const Color.fromARGB(255, 235, 235, 235),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: blackBg),
    scaffoldBackgroundColor: blackBg,
    colorScheme: ColorScheme.dark(
      background: blackBg,
      primary: const Color.fromARGB(255, 50, 50, 50),
      secondary: Colors.grey[800]!,
      tertiary: Colors.grey.shade500,
      inversePrimary: const Color.fromARGB(255, 229, 229, 229),
      outline: const Color.fromARGB(255, 70, 70, 70),
    ));
