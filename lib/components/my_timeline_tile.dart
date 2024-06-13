import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile(
    this.text, {
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.arrow_right_rounded,
            size: 25,
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
