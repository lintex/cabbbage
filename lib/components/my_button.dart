import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = const Color.fromARGB(255, 193, 193, 193)});
  //final void Function()? onPressed;
  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        //文字颜色
        foregroundColor: MaterialStateProperty.all(Colors.black87),
        //设置圆角
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        //边框的宽度 和 颜色
        side: MaterialStateProperty.all(
          BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      //shape: const Border(),
      child: Text(text),
    );
  }
}
