import 'package:flutter/material.dart';

class MarathonInputTile extends StatelessWidget {
  const MarathonInputTile(
      {super.key,
      required this.title,
      required this.trailing,
      required this.onPressed});
  final String title;
  final Widget trailing;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                trailing,
                const Icon(
                  Icons.keyboard_arrow_right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
