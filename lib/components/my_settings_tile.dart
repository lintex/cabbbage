import 'package:flutter/material.dart';

class MySettingsTile extends StatelessWidget {
  const MySettingsTile(
      {super.key,
      required this.title,
      this.subtitle = '',
      this.trailing = '',
      required this.onPressed});
  final String title, subtitle, trailing;
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
            Row(
              children: [
                Text(
                  trailing,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey[600],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
