import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = const Color.fromARGB(255, 222, 222, 222),
      this.textColor = Colors.black87});
  //final void Function()? onPressed;
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(100, 48)),
        backgroundColor: MaterialStateProperty.all(color),
        //文字颜色
        foregroundColor: MaterialStateProperty.all(textColor),
        //设置圆角
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        //边框的宽度 和 颜色
        side: MaterialStateProperty.all(
          BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      //shape: const Border(),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
