import 'package:flutter/material.dart';

class MyCircleToolButton extends StatelessWidget {
  const MyCircleToolButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.iconSize = 21});
  final IconData icon;
  final void Function()? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //     onTap: onPressed,
    //     child: Container(
    //       width: 40, // 按钮宽度
    //       height: 40, // 按钮高度
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(25.0), // 圆形按钮
    //         border: Border.all(color: Colors.lightGreen[900]!, width: 2), // 边框
    //       ),
    //       child: Center(
    //         child: Icon(icon,
    //             color: Colors.lightGreen[900], size: iconSize), // 按钮图标
    //       ),
    //     ));

    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 230, 237, 215),
      splashColor: Colors.lightGreen[200],
      textColor: Colors.black87,
      padding: const EdgeInsets.all(15),
      shape: const CircleBorder(),
      elevation: 0,
      child: Icon(
        icon,
        size: iconSize,
      ),
    );
  }
}
