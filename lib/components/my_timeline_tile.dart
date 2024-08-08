import 'package:flutter/material.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile(
    this.child, {
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 30, 0),
      // padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Theme.of(context).colorScheme.primary
      ),
      child: IntrinsicHeight(
        //* 这个控件可以让左边指示条高度跟右边内容高度保持一致
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左边指示条
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Theme.of(context).colorScheme.secondary),
              width: 6,
              // height: 20,
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
