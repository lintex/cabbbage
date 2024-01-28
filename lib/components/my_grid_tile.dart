import 'package:flutter/material.dart';

//全部功能页面自定义GridTile

class MyGridTile extends StatelessWidget {
  const MyGridTile(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.icon});

  final void Function()? onPressed;
  final String title; //按钮下方文字及提示
  final IconData icon; //默认图标

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 设置以后点击空白地方才有效
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
