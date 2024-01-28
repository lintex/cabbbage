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
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 52, 131, 252)),
  brightness: Brightness.light,
  appBarTheme:
      const AppBarTheme(backgroundColor: Color.fromARGB(255, 244, 245, 247)),
  // colorScheme: ColorScheme.light(
  //   background: Color.fromARGB(255, 244, 245, 247),
  //   primary: Colors.grey[300]!,
  //   secondary: Colors.grey[400]!,
  //   tertiary: Colors.grey[500]!,
  // )
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey[850]!,
      secondary: Colors.grey[800]!,
      tertiary: Colors.grey.shade500,
    ));
