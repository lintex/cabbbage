import 'package:flutter/material.dart';

class MyTextDivider extends StatelessWidget {
  const MyTextDivider({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Expanded(
          //     child: Divider(
          //   thickness: 0.5,
          //   color: Color.fromARGB(174, 189, 189, 189),
          // )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              style: const TextStyle(
                  color: Color.fromARGB(180, 97, 97, 97),
                  fontSize: 16,
                  fontFamily: "干就完事了"),
            ),
          ),
          // Expanded(
          //     child: Divider(
          //   thickness: 0.5,
          //   color: Colors.grey[400],
          // )),
        ],
      ),
    );
  }
}
