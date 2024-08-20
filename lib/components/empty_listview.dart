import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView(
      {super.key,
      required this.items,
      required this.child,
      required this.onPressed});
  final List items;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? child
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("没有数据！",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                    GestureDetector(
                      onTap: onPressed,
                      child: Text("点击添加",
                          style:
                              TextStyle(color: Theme.of(context).focusColor)),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
