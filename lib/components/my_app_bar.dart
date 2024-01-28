import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      //backgroundColor: bg,
      centerTitle: true,
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
      //   onPressed: () => Get.back(),
      // ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
