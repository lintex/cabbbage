import 'package:flutter/material.dart';

class MyFloatActionButton extends StatelessWidget {
  const MyFloatActionButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      // 关闭阴影
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.inversePrimary,
        size: 35,
      ),
    );
  }
}
