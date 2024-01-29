import 'package:flutter/material.dart';

//日间模式
Color bg = const Color.fromARGB(255, 244, 245, 247);
Color blue = const Color.fromARGB(255, 52, 131, 252);
Color blueBg = const Color.fromARGB(255, 222, 239, 255);
Color greyBg = const Color.fromARGB(255, 247, 247, 247);
Color yellow = const Color.fromARGB(255, 236, 176, 56);
Color red = const Color.fromARGB(255, 193, 56, 72);
Color grey = const Color.fromARGB(255, 159, 159, 159);
//暗黑模式
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
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    colorScheme: ColorScheme.dark(
      background: const Color.fromARGB(255, 36, 36, 36),
      primary: const Color.fromARGB(255, 50, 50, 50),
      secondary: Colors.grey[800]!,
      tertiary: Colors.grey.shade500,
      inversePrimary: const Color.fromARGB(255, 229, 229, 229),
    ));
