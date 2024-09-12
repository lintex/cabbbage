import 'package:cabbbage/components/my_trailing.dart';
import 'package:flutter/material.dart';

class MySettingsTile extends StatelessWidget {
  const MySettingsTile(
      {super.key,
      required this.title,
      this.subtitle = '',
      this.trailing = const MyTrailing(),
      required this.onPressed});
  final String title, subtitle;
  final Widget trailing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
                Offstage(
                  offstage: subtitle == '',
                  child: Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ],
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
