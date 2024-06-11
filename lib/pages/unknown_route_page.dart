import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(title: "UnknownRoutePage"),
        body: Center(child: Text('页面不存在！')));
  }
}
