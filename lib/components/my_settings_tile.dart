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
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: GestureDetector(
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
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
