import 'package:flutter/material.dart';

class MyTrailing extends StatelessWidget {
  const MyTrailing({super.key, this.text = ''});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(
          width: 5,
        ),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Theme.of(context).colorScheme.tertiary,
        )
      ],
    );
  }
}
