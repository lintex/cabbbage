import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumSliverAppBar extends StatelessWidget {
  const MediumSliverAppBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          title,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Get.back(),
      ),
      elevation: 0,
    );
  }
}
