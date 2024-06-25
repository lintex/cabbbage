import 'package:flutter/material.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile(
    this.child, {
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: IntrinsicHeight(
        //* 这个控件可以让左边指示条高度跟右边内容高度保持一致
        child: Row(
          children: [
            // 左边指示条
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              width: 8,
              margin: const EdgeInsets.only(right: 10),
            ),
            // 右边内容显示
            Expanded(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
