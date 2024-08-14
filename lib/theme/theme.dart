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
Color buttonBg = const Color.fromARGB(255, 240, 240, 240);
// 蓝色按钮背景 52,130,255 按钮文字255
Color blueButtonBg = const Color.fromARGB(255, 52, 130, 255);
Color blueButtonText = const Color.fromARGB(255, 255, 255, 255);
// 蓝色listTile背景 234,242,255 文字 61,129,240
Color blueTileBg = const Color.fromARGB(255, 234, 242, 255);
Color blueTileText = const Color.fromARGB(255, 61, 129, 240);

// 暗黑模式
// 纯黑背景  0,  0,  0 文字 143,143,143  亮色161,灰色72
// 弹出窗口背景 36, 36, 36 文字234
// 按钮背景  69, 69, 69  按钮文字 200,200,200
// 蓝色按钮背景 38,122,247 按钮文字 234,242,253

Color blackBg = const Color.fromARGB(255, 36, 36, 36);
Color greyText = const Color.fromARGB(255, 50, 50, 50);
Color whiteText = const Color.fromARGB(255, 229, 229, 229);

// 原dashboard Note背景色 color: const Color.fromARGB(255, 241, 240, 231)

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: bg,
      surfaceTintColor: bg, // 这个颜色设置后，AppBar背景不会因为下面滚动内容而变化
    ),
    dividerTheme:
        const DividerThemeData(color: Colors.transparent), // 去除底部分隔线颜色
    scaffoldBackgroundColor: bg,
    colorScheme: ColorScheme.light(
      background: bg,
      primary: const Color.fromARGB(255, 233, 233, 233),
      onPrimary: Colors.black54,
      secondary: Colors.grey.shade300,
      tertiary: Colors.grey.shade500,
      primaryContainer: Colors.lightGreen.shade100,
      onPrimaryContainer: Colors.lightGreen.shade400,
      inversePrimary: Colors.black87,
      outline: const Color.fromARGB(255, 235, 235, 235),
      shadow: const Color.fromARGB(255, 222, 222, 222),
      error: Colors.deepOrange.shade100,
      onError: Colors.deepOrange.shade400,
      surfaceTint: Colors.yellow.shade200.withOpacity(0.6), // note 画线文字背景
    ),
    // * 文字选择手柄颜色
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.lightGreen.shade700,
        selectionColor: Colors.lightGreen.shade200,
        selectionHandleColor: Colors.lightGreen.shade700),
    // floatActionButton 颜色
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.lightGreen.shade300,
    ),
    checkboxTheme: const CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    ),
    // TextField 聚焦颜色
    focusColor: Colors.lightGreen,
    // 按钮点击喷溅 颜色
    splashColor: Colors.lightGreen);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: blackBg,
      surfaceTintColor: blackBg,
    ),
    dividerTheme:
        const DividerThemeData(color: Colors.transparent), // 去除底部分隔线颜色
    scaffoldBackgroundColor: blackBg,
    colorScheme: ColorScheme.dark(
      background: blackBg,
      primary: const Color.fromARGB(255, 50, 50, 50),
      onPrimary: Colors.white38,
      secondary: Colors.grey.shade800,
      tertiary: Colors.grey.shade500,
      // list tile 背景色
      primaryContainer: const Color.fromARGB(255, 33, 48, 18),
      onPrimaryContainer: Colors.lightGreen.shade900,
      inversePrimary: const Color.fromARGB(255, 229, 229, 229),
      outline: const Color.fromARGB(255, 70, 70, 70),
      shadow: const Color.fromARGB(255, 12, 12, 12),
      error: const Color.fromARGB(255, 75, 16, 16),
      onError: const Color.fromARGB(255, 114, 25, 25),
      surfaceTint: const Color.fromARGB(255, 69, 64, 16), // note 画线文字背景
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.lightGreen.shade700,
        selectionColor: Colors.lightGreen.shade200,
        selectionHandleColor: Colors.lightGreen.shade700),
    // floatActionButton 颜色
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 60, 84, 32),
    ),
    // TextField 聚焦颜色
    focusColor: Colors.lightGreen.shade900,
    // 按钮点击喷溅 颜色
    splashColor: Colors.lightGreen.shade700);
