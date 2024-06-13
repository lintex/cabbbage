import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: MyAppBar(title: "TodoPage"), body: Center());
  }
}
