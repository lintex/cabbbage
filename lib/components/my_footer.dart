import 'package:flutter/material.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "卷",
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.tertiary),
          ),
          const SizedBox(
            width: 9,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 20,
            // color: Colors.black,
            // colorBlendMode: BlendMode.color,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            "菜",
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.tertiary),
          ),
        ],
      ),
    );
  }
}
